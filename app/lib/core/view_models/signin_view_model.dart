import 'package:app/core/enums/auth_result_status.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialogs/dialogs_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/auth_exception.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home/home.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  ExceptionHandler exceptionHandler;
  final DialogService _dialogService = locator<DialogService>();
  Future signIn({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);
    var result = await _authenticationService.signIn(
      email: email,
      password: password,
    );
    setBusy(false);
    if (result == ResultStatus.successful) {
      _navigationService.navigateTo(HomeRootScreen.route);
    } else {
      final errorMessage = ExceptionHandler.exceptionMessage(result);
      await _dialogService.showDialog(
        title: 'Sign up failed',
        description: errorMessage,
      );
    }
  }
}
