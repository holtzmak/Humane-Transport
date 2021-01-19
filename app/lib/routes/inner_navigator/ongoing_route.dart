import 'package:app/screens/ongoing/ongoing.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for Ongoing
class OngoingRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          default:
            return OngoingTravel();
        }
      },
    );
  }
}
