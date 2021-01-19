import 'package:app/screens/new_travel/new_travel.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_one.dart';
import 'package:app/screens/new_travel/new_travel_journey/test_screen_two.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for NewTravel
class NewTravelRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case TestScreenOne.route:
            return TestScreenOne();
          case TestScreenTwo.route:
            return TestScreenTwo();

          default:
            return NewTravel();
        }
      },
    );
  }
}
