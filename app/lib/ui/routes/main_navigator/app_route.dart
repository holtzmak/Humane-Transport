import 'package:app/core/models/test_history.dart';
import 'package:app/ui/views/add_history/add_history.dart';
import 'package:app/ui/views/home/home.dart';
import 'package:app/ui/views/new_travel/new_travel_journey.dart/test_screen_one.dart';
import 'package:app/ui/views/new_travel/new_travel_journey.dart/test_screen_two.dart';
import 'package:app/ui/views/signin/sign_in.dart';
import 'package:app/ui/views/signup/signup.dart';
import 'package:app/ui/views/splash_screen/splash_screen.dart';
import 'package:app/ui/views/user_profile/user_profile.dart';
import 'package:app/ui/views/welcome/welcome.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case SplashScreen.route:
            return SplashScreen();

          case WelcomeScreen.route:
            return WelcomeScreen();

          case SignInScreen.route:
            return SignInScreen();

          case SignUpScreen.route:
            return SignUpScreen();

          case HomeRootScreen.route:
            return HomeRootScreen();

          case AddHistory.route:
            /*
            Passes history info as an argument, so that when editting
            there will be inital value on the text field.
            */
            var postToEdit = settings.arguments as HistoryRecord;
            return AddHistory(editHistory: postToEdit);

          case TestScreenOne.route:
            return TestScreenOne();

          case TestScreenTwo.route:
            return TestScreenTwo();

          case UserProfile.route:
            return UserProfile();

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
