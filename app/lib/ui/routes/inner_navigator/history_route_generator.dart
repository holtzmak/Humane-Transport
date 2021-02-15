import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for History
class HistoryRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        // These routes contain a bottom nav
        switch (settings.name) {
          case PDFScreen.route:
            return PDFScreen();

          default:
            return HistoryScreen();
        }
      },
    );
  }
}
