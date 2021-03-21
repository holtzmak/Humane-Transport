import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/sign_in_screen.dart';
import 'package:app/ui/views/welcome_screen.dart';
import 'package:flutter/material.dart';

// TODO: Update Signup view model based on new changes made on task #207
class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _imageUrl;
  String get imageUrl => _imageUrl;

  void navigateToWelcomeScreen() =>
      _navigationService.navigateBackUntil(WelcomeScreen.route);

  void navigateToSignInScreen() =>
      _navigationService.navigateAndReplace(SignInScreen.route);

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
      displayImageUrl: _imageUrl ?? "",
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
