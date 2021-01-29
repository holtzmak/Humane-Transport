import 'package:app/ui/views/home/home.dart';
import 'package:app/ui/views/new_travel/new_travel_journey.dart/test_screen_one.dart';
import 'package:app/ui/views/new_travel/new_travel_journey.dart/test_screen_two.dart';
import 'package:app/ui/views/signin/sign_in.dart';
import 'package:app/ui/views/welcome/welcome.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case Welcome.route:
            return Welcome();

          case SignInScreen.route:
            return SignInScreen();

          case HomeRootScreen.route:
            return HomeRootScreen();

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
