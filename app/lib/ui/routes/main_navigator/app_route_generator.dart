import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_one.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_two.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:flutter/material.dart';

/// The main route generator for routes since app main
class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        /* These routes do not contain a bottom nav.
           These routes will be pushed on top of inner navigator routes,
           blocking them.
         */
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

          case ATRDisplay.route:
            return ATRDisplay(atr: settings.arguments);

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
