import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../test_lib/test_animal_transport_record.dart';

class MockNavigationService extends Mock implements NavigationService {}

final testLocator = GetIt.instance;

void main() {
  void expectInformation(WidgetTester tester, AnimalTransportRecord testRecord,
      String headerExpected, String informationExpected) async {
    await tester
        .pumpWidget(new MaterialApp(home: ATRDisplayScreen(atr: testRecord)));

    /* At the time of writing, we're using ExpansionPanels.
         Despite the expanded information not being visible initially,
         the official tests do not check visibility programmatically
         https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/expansion_panel_test.dart
         */
    expect(find.widgetWithText(ListTile, headerExpected), findsOneWidget);
    expect(find.widgetWithText(ListTile, informationExpected), findsOneWidget);
  }

  group('Animal Transport Record Display', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<NavigationService>(
          () => MockNavigationService());
    });

    testWidgets('shows right shipping info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withShipInfo(ShipperInfo(
          shipperName: "Dave Goodman",
          shipperIsAnimalOwner: true,
          departureLocationId: "ABCDEFG",
          departureLocationName: "Goodman Goods",
          departureAddress: testAddress(),
          shipperContactInfo: "1306111111"));
      expectInformation(tester, testRecord, "Shipper\'s Information",
          testRecord.shipInfo.toString());
    });
    testWidgets('shows right transporter info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withTransporterInfo(
          testTransporterInfo(
              companyName: "John Company",
              driverNames: ["Jane Doe", "Jack Son"],
              trainingType: "Standard training"));
      expectInformation(tester, testRecord, "Transporter\'s Information",
          testRecord.tranInfo.toString());
    });
    testWidgets('shows right FWR info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withFwrInfo(
          testFwrInfo(lastFwrDate: DateTime.parse("2021-01-01 01:01")));
      expectInformation(tester, testRecord, "Feed, Water, and Rest Information",
          testRecord.fwrInfo.toString());
    });
    testWidgets('shows right loading info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withVehicleInfo(
          testVehicleInfo(
              dateAndTimeLoaded: DateTime.parse("2021-02-02 02:02")));
      expectInformation(tester, testRecord, "Loading Vehicle Information",
          testRecord.vehicleInfo.toString());
    });
    testWidgets('shows right delivery info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(arrivalDate: DateTime.parse("2021-03-03 03:03")));
      expectInformation(tester, testRecord, "Delivery Information",
          testRecord.deliveryInfo.toString());
    });
    testWidgets('shows right acknowledgement info',
        (WidgetTester tester) async {
      // TODO: Use test/mock files here once we have a way to show acks
      final testRecord = testAnimalTransportRecord();
      expectInformation(tester, testRecord, "Acknowledgements",
          testRecord.ackInfo.toString());
    });
    testWidgets('shows right contingency info', (WidgetTester tester) async {
      final testRecord = testAnimalTransportRecord().withContingencyInfo(
          testContingencyInfo(goalStatement: "To move animals safely"));
      expectInformation(tester, testRecord, "Contingency Plan",
          testRecord.contingencyInfo.toString());
    });
  });
}
