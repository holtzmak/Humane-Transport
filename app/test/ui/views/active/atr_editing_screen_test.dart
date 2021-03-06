import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/active/form_field/acknowledgement_info_form_field.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_info_form_field.dart';
import 'package:app/ui/views/active/form_field/delivery_info_form_field.dart';
import 'package:app/ui/views/active/form_field/fwr_info_form_field.dart';
import 'package:app/ui/views/active/form_field/loading_vehicle_info_form_field.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/views/active/form_field/transporter_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNavigationService extends Mock implements NavigationService {}

class MockDialogService extends Mock implements DialogService {}

class MockActiveScreenViewModel extends Mock implements ActiveScreenViewModel {}

final testLocator = GetIt.instance;

void main() {
  final mockActiveScreenViewModel = MockActiveScreenViewModel();

  Future<void> pumpATREditingScreen(
          WidgetTester tester, AnimalTransportRecord initialATR) async =>
      tester.pumpWidget(MaterialApp(home: ATREditingScreen(atr: initialATR)));

  group('ATR Editing Screen', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<ActiveScreenViewModel>(
          () => mockActiveScreenViewModel);
    });

    testWidgets('has shipping info form field', (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(ShipperInfoFormField), findsOneWidget);
    });

    testWidgets('has transporter info form field', (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(TransporterInfoFormField), findsOneWidget);
    });

    testWidgets('has feed, water, rest info form field',
        (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(FeedWaterRestInfoFormField), findsOneWidget);
    });

    testWidgets('has loading vehicle info form field',
        (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(LoadingVehicleInfoFormField), findsOneWidget);
    });

    testWidgets('has delivery info form field', (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(DeliveryInfoFormField), findsOneWidget);
    });

    testWidgets('has acknowledgement info form field',
        (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(AcknowledgementInfoFormField), findsOneWidget);
    });

    testWidgets('has contingency plan info form field',
        (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(ContingencyPlanInfoFormField), findsOneWidget);
    });

    testWidgets('shows submit button', (WidgetTester tester) async {
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      await tester.ensureVisible(submitButtonFinder);
      expect(submitButtonFinder, findsOneWidget);
    });

    testWidgets('gives completed ATR to view model on submit',
        (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord();
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      when(mockActiveScreenViewModel.saveCompletedAtr(testATR))
          .thenAnswer((_) => Future.value()); // do nothing for test
      await pumpATREditingScreen(tester, testATR);
      await tester.ensureVisible(submitButtonFinder);
      await tester.tap(submitButtonFinder);
      // Non-standard submission time
      await tester.pump(Duration(milliseconds: 1));
      verify(mockActiveScreenViewModel.saveCompletedAtr(testATR)).called(1);
    });

    testWidgets('edited completed ATR is given to view model on submission',
        (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord(
          shipInfo: testShipperInfo(shipperName: "Ali Rae"));
      final editedATR = testAnimalTransportRecord(
          shipInfo: testShipperInfo(shipperName: "Alicia Rae"));
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      final fieldFinder = find.widgetWithText(TextFormField, "Ali Rae");
      when(mockActiveScreenViewModel.saveCompletedAtr(testATR))
          .thenAnswer((_) => Future.value()); // do nothing for test

      await pumpATREditingScreen(tester, testATR);
      // Edit
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, "Alicia Rae");
      // Submit
      await tester.ensureVisible(submitButtonFinder);
      await tester.tap(submitButtonFinder);
      // Non-standard submission time
      await tester.pump(Duration(milliseconds: 1));
      verify(mockActiveScreenViewModel.saveCompletedAtr(editedATR)).called(1);
    });

    testWidgets('gives saved ATR to view model on exit, then exits',
        (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord();
      final backButtonFinder = find.byIcon(Icons.arrow_back_ios);
      when(mockActiveScreenViewModel.saveEditedAtr(testATR))
          .thenAnswer((_) => Future.value()); // do nothing for test

      await pumpATREditingScreen(tester, testATR);
      await tester.ensureVisible(backButtonFinder);
      await tester.tap(backButtonFinder);
      // Non-standard save time
      await tester.pump(Duration(milliseconds: 1));
      verify(mockActiveScreenViewModel.saveEditedAtr(testATR)).called(1);
    });

    testWidgets('edited ATR is given to view model on exit, then exits',
        (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord(
          fwrInfo:
              testFwrInfo(lastFwrLocation: testAddress(city: "Yellowknife")));
      final editedATR = testAnimalTransportRecord(
          fwrInfo: testFwrInfo(lastFwrLocation: testAddress(city: "Iqaluit")));
      final backButtonFinder = find.byIcon(Icons.arrow_back_ios);
      final fieldFinder = find.widgetWithText(TextFormField, "Yellowknife");
      when(mockActiveScreenViewModel.saveEditedAtr(testATR))
          .thenAnswer((_) => Future.value()); // do nothing for test

      await pumpATREditingScreen(tester, testATR);
      // Edit
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, "Iqaluit");
      // Exit and save
      await tester.ensureVisible(backButtonFinder);
      await tester.tap(backButtonFinder);
      // Non-standard save time
      await tester.pump(Duration(milliseconds: 1));
      verify(mockActiveScreenViewModel.saveEditedAtr(editedATR)).called(1);
    });

    testWidgets('invalid form blocks completion submission',
        (WidgetTester tester) async {
      // TODO: Complete with form validation
      // Maybe also add different tests for the upcoming progress bar tied to validation
    });
  });
}
