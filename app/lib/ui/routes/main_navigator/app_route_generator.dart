import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/new/test_screens/test_screen_three.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/views/signup/sign_up_screen.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

/// The main route generator for routes since app main
class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (BuildContext context) {
        /* These routes do not contain a bottom nav.
           These routes will be pushed on top of the root route.
         */
        switch (settings.name) {
          case WelcomeScreen.route:
            return WelcomeScreen();
          case SignInScreen.route:
            return SignInScreen();
          case SignUpScreen.route:
            return SignUpScreen();
          case HomeScreen.route:
            return HomeScreen();
          case TestScreenThree.route:
            return TestScreenThree();
          case ATRDisplayScreen.route:
            return ATRDisplayScreen(atr: settings.arguments);
          case ATREditingScreen.route:
            return ATREditingScreen(atr: settings.arguments);

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
