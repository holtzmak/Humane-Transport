import 'dart:async';

import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/account/account_editing_screen.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'base_view_model.dart';

class AccountScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

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

  void navigateToAccountEditingScreen() => _navigationService
      .navigateTo(AccountEditingScreen.route, arguments: _transporter);

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}
