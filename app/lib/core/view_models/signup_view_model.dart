import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  //Inject auth service
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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
    if (result is bool) {
      /*
      The problem here is that we completely seperated our business logic to our UI and therefore
      do not have any access to context. When everything is mixed up, we can do the following:
      Navigator.pushNamed(context, route); But since we dont have access to context, we will use
      a service that will do such thing for us
       */
      if (result) {
        popScreen();
      } else {
        //Otherwise, we show the error message
        print('Please try again later');
      }
    } else {
      //If it's not a bool type, then something went wrong
      //Checks if password is correct, email is formatted and etc
      print(result);
    }
  }
}
