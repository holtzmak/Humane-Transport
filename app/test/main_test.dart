import 'package:app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HumaneTransportApp says hello world',
      (WidgetTester tester) async {
    await tester.pumpWidget(HumaneTransportApp());
    final textFinder = find.text('Hello World');
    expect(textFinder, findsOneWidget);
  });
}
