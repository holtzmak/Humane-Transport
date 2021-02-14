import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';

// TODO: Update as per #152.
class SignInViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signIn({
    @required String email,
    @required String password,
  }) async {
    setState(ViewState.Busy);
    _authenticationService.signIn(email: email, password: password).then((_) {
      _navigationService.navigateTo(HomeScreen.route);
      setState(ViewState.Idle);
    }).catchError((error) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Sign in failed',
        description: error.message,
      );
    });
  }
}
