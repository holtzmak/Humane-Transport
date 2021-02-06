import 'package:app/core/enums/auth_result_status.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialogs/dialogs_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/auth_exception.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  //Inject auth service
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  Future signUp({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
    @required String password,
  }) async {
    setBusy(true);
    var result = await _authenticationService.signUp(
      userEmailAddress: userEmailAddress,
      password: password,
      firstName: firstName,
      lastName: lastName,
      userPhoneNumber: userPhoneNumber,
    );
    setBusy(false);
    if (result == ResultStatus.successful) {
      popScreen();
    } else {
      final errorMessage = ExceptionHandler.exceptionMessage(result);
      print(errorMessage);
      await _dialogService.showDialog(
        title: 'Sign up failed',
        description: errorMessage,
      );
    }
  }
}
