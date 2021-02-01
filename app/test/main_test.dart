import 'package:app/core/services/service_locator.dart';
import 'package:app/humane_transport_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Group test', () {
    setUpAll(() {
      // TODO: Make a test locator
      setUpLocator();
    });

    testWidgets('HumaneTransportApp says Welcome', (WidgetTester tester) async {
      await tester.pumpWidget(HumaneTransportApp());
      final textFinder = find.text('Welcome User');
      expect(textFinder, findsOneWidget);
    });
  });
}
