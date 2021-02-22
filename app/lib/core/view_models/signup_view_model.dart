import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToWelcomeScreen() => _navigationService.pop();

  Future<void> signUp({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
    @required String password,
  }) async {
    setState(ViewState.Busy);
    _authenticationService
        .signUp(
      userEmailAddress: userEmailAddress,
      password: password,
      firstName: firstName,
      lastName: lastName,
      userPhoneNumber: userPhoneNumber,
    )
        .then((_) {
      _navigationService.navigateTo(SignInScreen.route);
      setState(ViewState.Idle);
    }).catchError((error) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Sign up failed',
        description: error.message,
      );
    });
  }
}
