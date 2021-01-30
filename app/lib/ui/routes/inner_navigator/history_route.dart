import 'package:app/core/utilities/pdf_preview.dart';
import 'package:app/ui/views/history/history.dart';
import 'package:flutter/material.dart';

/// The inner [Navigator] for History
class HistoryRouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case PdfPreview.route:
            return PdfPreview();
          default:
            return TravelHistory();
        }
      },
    );
  }
}
