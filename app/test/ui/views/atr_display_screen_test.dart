import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNavigationService extends Mock implements NavigationService {}

class MockHistoryScreenViewModel extends Mock
    implements HistoryScreenViewModel {}

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

  group('ATR Display Screen', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<NavigationService>(
          () => MockNavigationService());
      testLocator.registerLazySingleton<HistoryScreenViewModel>(
          () => MockHistoryScreenViewModel());
    });

    testWidgets('shows right shipping info', (WidgetTester tester) async {
      final testShipperName = "Dave Goodman";
      final testRecord = testAnimalTransportRecord()
          .withShipInfo(testShipperInfo(shipperName: testShipperName));
      expectInformation(
          tester, testRecord, "Shipper\'s Information", testShipperName);
    });

    testWidgets('shows right transporter info', (WidgetTester tester) async {
      final testDriverName = "Jackson Been";
      final testRecord = testAnimalTransportRecord().withTransporterInfo(
          testTransporterInfo(driverNames: [testDriverName]));
      expectInformation(
          tester, testRecord, "Transporter\'s Information", testDriverName);
    });

    testWidgets('shows right FWR info', (WidgetTester tester) async {
      final testDate = "2021-01-01 01:01";
      final testRecord = testAnimalTransportRecord()
          .withFwrInfo(testFwrInfo(lastFwrDate: DateTime.parse(testDate)));
      expectInformation(
          tester, testRecord, "Feed, Water, and Rest Information", testDate);
    });

    testWidgets('shows right loading info', (WidgetTester tester) async {
      final testDate = "2021-02-02 02:02";
      final testRecord = testAnimalTransportRecord().withVehicleInfo(
          testVehicleInfo(dateAndTimeLoaded: DateTime.parse(testDate)));
      expectInformation(
          tester, testRecord, "Loading Vehicle Information", testDate);
    });

    testWidgets('shows right delivery info', (WidgetTester tester) async {
      final testDate = "2021-03-03 03:03";
      final testRecord = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(arrivalDate: DateTime.parse(testDate)));
      expectInformation(tester, testRecord, "Delivery Information", testDate);
    });

    testWidgets('shows right acknowledgement info',
        (WidgetTester tester) async {
      // TODO: Use test/mock files here once we have a way to show acks
      final testAck = "Consignee acknowledgement";
      final testRecord = testAnimalTransportRecord();
      expectInformation(tester, testRecord, "Acknowledgements", testAck);
    });

    testWidgets('shows right contingency info', (WidgetTester tester) async {
      final testGoalStatement = "To move animals safely";
      final testRecord = testAnimalTransportRecord().withContingencyInfo(
          testContingencyInfo(goalStatement: testGoalStatement));
      expectInformation(
          tester, testRecord, "Contingency Plan", testGoalStatement);
    });
  });
}
