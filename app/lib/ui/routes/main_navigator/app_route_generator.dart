import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/views/signup/sign_up_screen.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
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
          // TODO: #186. Prevent routing to certain screens when not logged in
          // Each screen could also listen to auth changes and boot bad Users
          // That's could be excessive, however.
          case WelcomeScreen.route:
            return WelcomeScreen();
          case SignInScreen.route:
            return SignInScreen();
          case SignUpScreen.route:
            return SignUpScreen();
          case HomeScreen.route:
            return HomeScreen();
          case ATRDisplayScreen.route:
            return ATRDisplayScreen(atr: settings.arguments);
          case ATREditingScreen.route:
            return ATREditingScreen(atr: settings.arguments);
          case PDFScreen.route:
            return PDFScreen();

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
