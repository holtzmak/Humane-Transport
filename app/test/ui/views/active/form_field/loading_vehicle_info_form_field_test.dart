import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/test/helper/test_animal_group_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/loading_vehicle_info_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(LoadingVehicleInfo infoExpected) {
    // Date and time are in separate fields
    expect(
        find.text(
            DateFormat('MMM d, yyyy').format(infoExpected.dateAndTimeLoaded)),
        findsOneWidget);
    expect(
        find.text(DateFormat('HH:mm').format(infoExpected.dateAndTimeLoaded)),
        findsOneWidget);

    expect(find.text(infoExpected.loadingArea.toString()), findsOneWidget);
    expect(find.text(infoExpected.loadingDensity.toString()), findsOneWidget);
    expect(find.text(infoExpected.animalsPerLoadingArea.toString()),
        findsOneWidget);
    infoExpected.animalsLoaded
        .forEach((animals) => verifyAnimalGroupIsShown(animals));
  }

  Future<void> pumpLoadingVehicleInfoFormField(
          WidgetTester tester,
          LoadingVehicleInfo testInfo,
          Function(LoadingVehicleInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: LoadingVehicleInfoFormField(
            initialInfo: testInfo, onSaved: callback),
      )))));

  group('Loading Vehicle Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testVehicleInfo = LoadingVehicleInfo(
          dateAndTimeLoaded: DateTime.parse("2021-02-03 13:01"),
          loadingArea: 4,
          loadingDensity: 2,
          animalsPerLoadingArea: 3,
          animalsLoaded: [
            testAnimalGroup(approximateWeight: 2000, numberAnimals: 12)
          ]);
      await pumpLoadingVehicleInfoFormField(tester, testVehicleInfo, (_) {
        // Do nothing for test
      });
      verifyInformationIsShown(testVehicleInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpLoadingVehicleInfoFormField(tester, testVehicleInfo(), (_) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testVehicleInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      LoadingVehicleInfo callbackInfo;
      final onSavedCallback = (LoadingVehicleInfo info) => callbackInfo = info;

      await pumpLoadingVehicleInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets(
        'calls onSaved with edited loading info when save button pressed',
        (WidgetTester tester) async {
      final initialLoading = 0;
      final editedLoading = 3;
      final testInfo = testVehicleInfo(loadingArea: initialLoading);
      final editedInfo = testVehicleInfo(loadingArea: editedLoading);

      LoadingVehicleInfo callback;
      final onSaved = (LoadingVehicleInfo changed) => callback = changed;

      final fieldFinder = find.text(initialLoading.toString());
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");

      await pumpLoadingVehicleInfoFormField(tester, testInfo, onSaved);
      // Edit text
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedLoading.toString());
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });
  });
}
