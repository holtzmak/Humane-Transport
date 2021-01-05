import 'package:app/humane_transport_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HumaneTransportApp says hello world',
      (WidgetTester tester) async {
    await tester.pumpWidget(HumaneTransportApp());
    final textFinder = find.text('This is Home Page');
    expect(textFinder, findsOneWidget);
  });
}
