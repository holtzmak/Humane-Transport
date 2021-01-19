import 'package:app/humane_transport_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HumaneTransportApp says Go to page with bottom nav',
      (WidgetTester tester) async {
    await tester.pumpWidget(HumaneTransportApp());
    final textFinder = find.text('Go to page with bottom nav');
    expect(textFinder, findsOneWidget);
  });
}
