import 'package:app/ui/views/active/active_screen.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for Active
class ActiveRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        // These routes contain a bottom nav
        switch (settings.name) {
          default:
            return ActiveScreen();
        }
      },
    );
  }
}
