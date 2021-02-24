import 'package:app/core/models/address.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/widgets/utility/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNavigationService extends Mock implements NavigationService {}

class MockDialogService extends Mock implements DialogService {}

class MockActiveScreenViewModel extends Mock implements ActiveScreenViewModel {}

final testLocator = GetIt.instance;

void main() {
  final mockNavService = MockNavigationService();
  final mockDialogService = MockDialogService();

  /* At the time of writing, we're using ExpansionPanels. Despite the expanded
     information not being visible initially, we don't need to expand the panel
     to make sure the information is in the widget tree
   */
  void verifyShipperInfoIsShown(ShipperInfo infoExpected) {
    expect(find.text(infoExpected.shipperName), findsOneWidget);
    // TODO: will have to verify this another way as there is a number of widgets with Yes/N0
    // expect(find.text(infoExpected.shipperIsAnimalOwner ? "Yes" : "No"),
    //     findsOneWidget);
    expect(find.text(infoExpected.departureLocationId), findsOneWidget);
    expect(find.text(infoExpected.departureLocationName), findsOneWidget);
    expect(
        find.text(infoExpected.departureAddress.streetAddress), findsOneWidget);
    expect(find.text(infoExpected.departureAddress.city), findsOneWidget);
    expect(find.text(infoExpected.departureAddress.provinceOrState),
        findsOneWidget);
    expect(find.text(infoExpected.departureAddress.country), findsOneWidget);
    expect(find.text(infoExpected.departureAddress.postalCode), findsOneWidget);
    expect(find.text(infoExpected.shipperContactInfo), findsOneWidget);
  }

  Future<void> pumpATREditingScreen(
          WidgetTester tester, AnimalTransportRecord initialATR) async =>
      tester.pumpWidget(MaterialApp(home: ATREditingScreen(atr: initialATR)));

  group('ATR Editing Screen', () {
    setUpAll(() async {
      testLocator
          .registerLazySingleton<NavigationService>(() => mockNavService);
      testLocator.registerLazySingleton<DialogService>(() => mockDialogService);
      testLocator.registerLazySingleton<ActiveScreenViewModel>(
          () => MockActiveScreenViewModel());
    });

    testWidgets('shows right shipping info', (WidgetTester tester) async {
      final testShipperInfo = ShipperInfo(
          shipperName: "Jackson Black",
          shipperIsAnimalOwner: true,
          departureLocationId: '67ag',
          departureLocationName: "Home Base",
          departureAddress: Address(
              streetAddress: "Some st.",
              city: "Some city",
              provinceOrState: "Some state",
              country: "Some country",
              postalCode: "ABCXYZ"),
          shipperContactInfo: "By phone");
      final testATR = testAnimalTransportRecord(shipInfo: testShipperInfo);
      await pumpATREditingScreen(tester, testATR);
      verifyShipperInfoIsShown(testShipperInfo);
    });

    testWidgets('shows submit button', (WidgetTester tester) async {
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      await tester.ensureVisible(submitButtonFinder);
      expect(submitButtonFinder, findsOneWidget);
    });

    testWidgets('launches dialog on submit', (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord();
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      when(mockDialogService.showDialog(
              title: anyNamed("title"),
              description: anyNamed("description"),
              buttonText: anyNamed("buttonText")))
          .thenAnswer((_) => Future.value(DialogResponse(confirmed: true)));
      when(mockNavService.pop()).thenAnswer((_) {
        // Do nothing for test
      });
      await pumpATREditingScreen(tester, testATR);
      await tester.ensureVisible(submitButtonFinder);
      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle();
      verify(mockDialogService.showDialog(
              title: anyNamed("title"),
              description: anyNamed("description"),
              buttonText: anyNamed("buttonText")))
          .called(1);
      verify(mockNavService.pop()).called(1);
    });

    testWidgets(
        'launches successful dialog on submit', (WidgetTester tester) async {});
    testWidgets(
        'launches failure dialog on submit', (WidgetTester tester) async {});
    testWidgets('gives completed ATR to database service on submit',
        (WidgetTester tester) async {});
    testWidgets('gives edited, completed ATR to database service on submit',
        (WidgetTester tester) async {});
    testWidgets(
        'closes on submit (prevent completed ATR from being edited further)',
        (WidgetTester tester) async {});
  });
}
