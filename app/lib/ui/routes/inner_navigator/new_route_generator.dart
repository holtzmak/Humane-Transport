import 'package:app/ui/views/new_travel/new_screen.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_one.dart';
import 'package:app/ui/views/new_travel/test_screens/test_screen_two.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for NewTravel
class NewRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case TestScreenOne.route:
            return TestScreenOne();
          case TestScreenTwo.route:
            return TestScreenTwo();
          case ImageScreen.route:
            return ImageScreen();

          default:
            return NewScreen();
        }
      },
    );
  }
}
