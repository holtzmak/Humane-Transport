import 'package:app/core/enums/view_state.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home/home.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseViewModel {
  //Inject auth service
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signIn({
    @required String email,
    @required String password,
  }) async {
    setState(ViewState.Busy);
    var result = await _authenticationService.signIn(
      email: email,
      password: password,
    );
    setState(ViewState.Idle);
    if (result is bool) {
      /*
      The problem here is that we completely separated our business logic to our UI and therefore
      do not have any access to context. When everything is mixed up, we can do the following:
      Navigator.pushNamed(context, route); But since we don't have access to context, we will use
      a service that will do such thing for us
       */
      if (result) {
        _navigationService.navigateTo(HomeRootScreen.route);
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
