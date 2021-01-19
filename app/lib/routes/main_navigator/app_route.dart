import 'package:app/screens/home/home.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_one.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_two.dart';

import 'package:flutter/material.dart';

class AppRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
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
