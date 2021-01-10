import 'package:app/humane_transport_app.dart';
import 'package:app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Not in setUpAll() due to: https://github.com/flutter/flutter/issues/72063
  // This will likely be fixed soon! Check again if your'e adding test here
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('siderbar test', () {
    testWidgets("tap on the siderbar; verify open sidebar",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Cheap way of getting at the drawer, we should use the state when we have stateful management
      await tester.dragFrom(
          tester.getTopLeft(find.byType(HumaneTransportApp)), Offset(300, 0));
      // Drags are fast but software is faster, wait
      await tester.pumpAndSettle();
      expect(find.text("Hello"), findsOneWidget);
    });
  });
}
