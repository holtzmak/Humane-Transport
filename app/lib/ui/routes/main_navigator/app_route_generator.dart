import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_one.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_two.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case WelcomeScreen.route:
            return WelcomeScreen();

          case SignInScreen.route:
            return SignInScreen();

          case HomeScreen.route:
            return HomeScreen();

          case TestScreenOne.route:
            return TestScreenOne();

          case TestScreenTwo.route:
            return TestScreenTwo();

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
