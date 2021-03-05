import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final List<AnimalTransportRecord> _animalTransportRecords = [];
  StreamSubscription<List<AnimalTransportRecord>> atrSubscription;
  StreamSubscription<Optional<User>> userSubscription;

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  HistoryScreenViewModel() {
    userSubscription = _authenticationService.currentUserChanges().listen(
        (user) => user.isPresent()
            ? atrSubscription = _databaseService
                .getUpdatedCompleteATRs(user.get().uid)
                .listen((atrs) {
                removeAll();
                addAll(atrs);
              })
            : _cancelAtrSubscription());
  }

  void _cancelAtrSubscription() {
    removeAll();
    atrSubscription.cancel();
  }

  @mustCallSuper
  void dispose() {
    userSubscription.cancel();
    _cancelAtrSubscription();
    super.dispose();
  }

  void addAll(List<AnimalTransportRecord> atrs) {
    _animalTransportRecords.addAll(atrs);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    notifyListeners();
  }

  void navigateToPDFScreen() {
    _navigationService.navigateTo(PDFScreen.route);
  }

  void navigateToHistoryScreen() {
    _navigationService.pop();
  }
}
