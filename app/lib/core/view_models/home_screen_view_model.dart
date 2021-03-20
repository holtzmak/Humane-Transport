import 'dart:async';

import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/account/account_screen.dart';
import 'package:app/ui/views/active/active_screen.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/views/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  StreamSubscription<Optional<User>> _currentUserSubscription;
  StreamSubscription<Transporter> _transporterSubscription;
  Transporter _transporter;

  Transporter get transporter => _transporter;

  @mustCallSuper
  void dispose() {
    _cancelTransporterSubscription();
    if (_currentUserSubscription != null) _currentUserSubscription.cancel();
    super.dispose();
  }

  void _cancelTransporterSubscription() {
    if (_transporterSubscription != null) _transporterSubscription.cancel();
  }

  void loadTransporterInfo() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser.isPresent()) {
      _transporterSubscription = _databaseService
          .getUpdatedTransporter(thisUser.get().uid)
          .listen((account) {
        _transporter = account;
        notifyListeners();
      });
      _currentUserSubscription = _authenticationService.currentUserChanges
          .listen((Optional<User> user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (!user.isPresent()) _cancelTransporterSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the account screen failed',
        description: "You are not logged in!",
      );
    }
  }

  void navigateToActiveScreen() =>
      _navigationService.navigateTo(ActiveScreen.route);

  void navigateToHistoryScreen() =>
      _navigationService.navigateTo(HistoryScreen.route);

  void navigateToAccountScreen() =>
      _navigationService.navigateTo(AccountScreen.route);

  void signOut() async {
    _authenticationService
        .signOut()
        .then((_) => _navigationService.navigateAndReplace(WelcomeScreen.route))
        .catchError((error) => _dialogService.showDialog(
              title: 'Sign out failed',
              description: error.message,
            ));
  }

  Future<void> startNewAtr() async {
    final currentUser = _authenticationService.currentUser;
    currentUser.isPresent()
        ? _databaseService
            .saveNewAtr(currentUser.get().uid)
            .then((atr) => _navigationService.navigateTo(ATREditingScreen.route,
                arguments: atr))
            .catchError((e) => _dialogService.showDialog(
                  title: 'Starting a new Animal Transport Record failed',
                  description: e.message,
                ))
        : _dialogService.showDialog(
            title: 'Starting a new Animal Transport Record failed',
            description: "You are not logged in!",
          );
  }
}
