import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../test_animal_transport_record.dart';

void main() {
  group('Animal Transport Record Preview', () {
    testWidgets('Previews right information', (WidgetTester tester) async {
      final testDate = DateTime.parse("2021-01-01 01:01");
      final testCompany = "Test Company";
      final testSpecies = "Cows";
      final testRecWithDelvInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      final testRecWithInfo = testRecWithDelvInfo.withVehicleInfo(
          testVehicleInfo(
              dateAndTimeLoaded: testDate,
              animalsLoaded: [testAnimalGroup(species: testSpecies)]));

      await tester.pumpWidget(new MaterialApp(
          home: AnimalTransportRecordPreview(atr: testRecWithInfo)));

      expect(find.text("Delivery for $testCompany"), findsOneWidget);
      expect(
          find.text(
              "${DateFormat("yyyy-MM-dd hh:mm").format(testDate)} $testSpecies"),
          findsOneWidget);
    });
  });
}
