import 'package:app/ui/views/ongoing/ongoing.dart';
import 'package:app/ui/views/user_profile/user_profile.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for Ongoing
class OngoingRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case UserProfile.route:
            return UserProfile();

          default:
            return OngoingTravel();
        }
      },
    );
  }
}
