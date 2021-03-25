import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/reset_password/check_your_email_account_screen.dart';
import 'package:app/ui/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToSignInScreen() =>
      _navigationService.navigateBackUntil(SignInScreen.route);

  Future<void> resetPassword({
    @required String email,
  }) async {
    setState(ViewState.Busy);
    _authenticationService.resetPassword(userEmailAddress: email).then((_) {
      _navigationService.navigateTo(ConfirmationMessageScreen.route);
      setState(ViewState.Idle);
    }).catchError((error) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Reset Password failed',
        description: error.message,
      );
    });
  }
}
