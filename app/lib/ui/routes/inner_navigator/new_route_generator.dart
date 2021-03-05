import 'package:app/ui/views/new/new_screen.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for NewTravel
class NewRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (BuildContext context) {
        // These routes contain a bottom nav
        switch (settings.name) {
          case NewScreen.route:
            return NewScreen();
          case ImageScreen.route:
            return ImageScreen();

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
