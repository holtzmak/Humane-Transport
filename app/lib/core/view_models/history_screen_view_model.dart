import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/active/active_screen.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  StreamSubscription<Optional<User>> _currentUserSubscription;
  StreamSubscription<List<AnimalTransportRecord>> _atrSubscription;

  final List<AnimalTransportRecord> _animalTransportRecords = [];

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  List<AnimalTransportRecord> _filteredAnimalTransportRecords = [];

  List<AnimalTransportRecord> get filteredAnimalTransportRecords =>
      List.unmodifiable(_filteredAnimalTransportRecords);

  HistoryScreenViewModel() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser.isPresent()) {
      _databaseService
          .getTransporter(thisUser.get().uid)
          .then((Transporter transporter) {
        _atrSubscription = transporter.isAdmin
            ? _databaseService
                .getAllUpdatedCompleteATRs()
                .listen((List<AnimalTransportRecord> atrs) {
                removeAll();
                addAll(atrs);
              })
            : _databaseService
                .getUpdatedCompleteATRs(transporter.userId)
                .listen((List<AnimalTransportRecord> atrs) {
                removeAll();
                addAll(atrs);
              });
      }).catchError((error) {
        _dialogService.showDialog(
          title: 'Launching the history screen failed',
          description: error.message,
        );
      });
      _currentUserSubscription = _authenticationService.currentUserChanges
          .listen((Optional<User> user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (!user.isPresent()) _cancelAtrSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the history screen failed',
        description: "You are not logged in!",
      );
    }
  }

  void _cancelAtrSubscription() {
    removeAll();
    if (_atrSubscription != null) _atrSubscription.cancel();
  }

  @mustCallSuper
  void dispose() {
    _cancelAtrSubscription();
    if (_currentUserSubscription != null) _currentUserSubscription.cancel();
    super.dispose();
  }

  void addAll(List<AnimalTransportRecord> atrs) {
    _animalTransportRecords.addAll(atrs);
    _filteredAnimalTransportRecords = _animalTransportRecords;
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    _filteredAnimalTransportRecords.clear();
    notifyListeners();
  }

  void filterBySearchTerm(String searchTerm) {
    _filteredAnimalTransportRecords = _animalTransportRecords
        .where((AnimalTransportRecord atr) =>
            atr.toString().toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void navigateToDisplayScreen(AnimalTransportRecord atr) =>
      _navigationService.navigateTo(ATRDisplayScreen.route, arguments: atr);

  void navigateToPDFScreen(AnimalTransportRecord atr) =>
      _navigationService.navigateTo(PDFScreen.route, arguments: atr);

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  void navigateToHistoryScreen() =>
      _navigationService.navigateBackUntil(HistoryScreen.route);

  void navigateToActiveScreen() =>
      _navigationService.navigateAndReplace(ActiveScreen.route);
}
