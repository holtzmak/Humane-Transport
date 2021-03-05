import 'package:app/test/test_data.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('ATR Preview Card', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testDate = DateTime.parse("2021-01-01 01:01");
      final testCompany = "Test Company";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      final testRecWithInfo = testRecWithDelInfo
          .withVehicleInfo(testVehicleInfo(dateAndTimeLoaded: testDate));

      await tester.pumpWidget(new MaterialApp(
          home: ATRPreviewCard(
        atr: testRecWithInfo,
        onTap: () {
          // Do nothing for test
        },
      )));

      expect(find.byIcon(Icons.folder), findsOneWidget);
      expect(find.text("Transport for $testCompany"), findsOneWidget);
      expect(find.text("${DateFormat("yyyy-MM-dd hh:mm").format(testDate)}"),
          findsOneWidget);
    });

    testWidgets('calls function on tap', (WidgetTester tester) async {
      final testCompany = "Test Company";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      bool callback;
      final testCallback = () => callback = true;
      final widget = ATRPreviewCard(
        atr: testRecWithDelInfo,
        onTap: testCallback,
      );
      await tester.pumpWidget(new MaterialApp(home: widget));
      await tester.tap(find.text("Transport for $testCompany"));
      await tester.pumpAndSettle();
      expect(callback, true);
    });
  });
}
