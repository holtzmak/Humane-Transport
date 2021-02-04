import 'package:app/core/models/shipper_info.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_lib/test_animal_transport_record.dart';

void main() {
  group('Animal Transport Record Display', () {
    testWidgets('shows right shipping info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withShipInfo(ShipperInfo(
          shipperName: "Dave Goodman",
          shipperIsAnimalOwner: true,
          departureLocationId: "ABCDEFG",
          departureLocationName: "Goodman Goods",
          departureAddress: testAddress(),
          shipperContactInfo: "1306111111"));

      await tester.pumpWidget(
          new MaterialApp(home: AnimalTransportRecordDisplay(atr: testRecord)));

      /* At the time of writing, we're using ExpansionPanels.
         Despite the expanded information not being visible initially,
         the official tests do not check visibility programmatically
         https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/expansion_panel_test.dart
         */
      expect(find.widgetWithText(ListTile, "Shipping Information"),
          findsOneWidget);
      expect(find.widgetWithText(ListTile, testRecord.shipInfo.toString()),
          findsOneWidget);
    });
  });
}
