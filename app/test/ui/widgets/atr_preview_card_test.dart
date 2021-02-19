import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('ATR Preview Card', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testDate = DateTime.parse("2021-01-01 01:01");
      final testCompany = "Test Company";
      final testSpecies = "Cows";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      final testRecWithInfo = testRecWithDelInfo.withVehicleInfo(
          testVehicleInfo(
              dateAndTimeLoaded: testDate,
              animalsLoaded: [testAnimalGroup(species: testSpecies)]));

      await tester.pumpWidget(new MaterialApp(
          home: ATRPreviewCard(
        atr: testRecWithInfo,
        onTap: () {
          // Do nothing for test
        },
      )));

      expect(find.text("Delivery for $testCompany"), findsOneWidget);
      expect(
          find.text(
              "${DateFormat("yyyy-MM-dd hh:mm").format(testDate)} $testSpecies"),
          findsOneWidget);
    });
  });
}
