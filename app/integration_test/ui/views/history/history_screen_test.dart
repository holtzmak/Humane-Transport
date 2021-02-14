import 'package:app/main.dart' as app;
import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Not in setUpAll() due to: https://github.com/flutter/flutter/issues/72063
  // This will likely be fixed soon! Check again if you're adding tests here
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToHistoryScreen(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(RaisedButton, "Skip sign in"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("History"));
    await tester.pumpAndSettle();
  }

  // Some of these are system tests. They will likely be moved from history to system_test dir in the future.
  group('History screen', () {
    testWidgets(
        "successfully retrieve one ATR from remote for specific Transporter",
        (WidgetTester tester) async {
      // Ensure app is in good state before testing
      app.main();
      await tester.pumpAndSettle();
      await navigateToHistoryScreen(tester);

      // Wait for cheap stream to load in
      await tester.pump(Duration(seconds: 6));
      expect(find.byType(ATRPreview), findsOneWidget);
    });
  });
}
