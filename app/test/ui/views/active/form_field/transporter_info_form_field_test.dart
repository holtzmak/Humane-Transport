import 'package:app/core/models/address.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/test/test_address_expectations.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/form_field/transporter_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(TransporterInfo infoExpected) {
    expect(find.text(infoExpected.companyName), findsOneWidget);
    verifyAddressIsShown(infoExpected.companyAddress);
    infoExpected.driverNames.forEach((name) {
      expect(find.text(name), findsOneWidget);
    });
    expect(find.text(infoExpected.vehicleProvince), findsOneWidget);
    expect(find.text(infoExpected.vehicleLicensePlate), findsOneWidget);
    expect(find.text(infoExpected.trailerProvince), findsOneWidget);
    expect(find.text(infoExpected.trailerLicensePlate), findsOneWidget);
    verifyAddressIsShown(infoExpected.addressLastCleanedAt);

    // DropDownButtonFormFields have the values offscreen, so both are present
    expect(find.text(infoExpected.driversAreBriefed ? "Yes" : "No"),
        findsNWidgets(2));
    expect(find.text(infoExpected.driversHaveTraining ? "Yes" : "No"),
        findsNWidgets(2));

    expect(find.text(infoExpected.trainingType), findsOneWidget);
  }

  Future<void> pumpTransporterInfoFormField(WidgetTester tester,
          TransporterInfo testInfo, Function(TransporterInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child:
            TransporterInfoFormField(initialInfo: testInfo, onSaved: callback),
      )))));

  group('Transporter Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testTransporterInfo = TransporterInfo(
          companyName: "Temp Company",
          companyAddress: testAddress(),
          driverNames: ["Sally Listen, John Cobb"],
          vehicleProvince: "Saskatchewan",
          vehicleLicensePlate: "ABC345",
          trailerProvince: "Ontario",
          trailerLicensePlate: "IGH342",
          dateLastCleaned: DateTime.parse("2021-02-03 13:01"),
          addressLastCleanedAt: Address(
              streetAddress: "456 St.",
              city: "Calgary",
              provinceOrState: "Alberta",
              country: "Canada",
              postalCode: "4h5yu6"),
          driversAreBriefed: false,
          driversHaveTraining: true,
          trainingType: "Temp",
          trainingExpiryDate: DateTime.parse("2021-02-07 05:01"));
      await pumpTransporterInfoFormField(tester, testTransporterInfo,
          (TransporterInfo info) {
        // Do nothing for test
      });
      verifyInformationIsShown(testTransporterInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpTransporterInfoFormField(tester, testTransporterInfo(),
          (TransporterInfo info) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testTransporterInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      TransporterInfo callbackInfo;
      final onSavedCallback = (TransporterInfo info) => callbackInfo = info;

      await pumpTransporterInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets(
        'calls onSaved with edited address info when save button pressed',
        (WidgetTester tester) async {
      final initialStreet = "ABC Street";
      final editedStreet = "Edited Street";
      final testInfo = testTransporterInfo(
          companyAddress: testAddress(streetAddress: initialStreet));
      final editedInfo = testTransporterInfo(
          companyAddress: testAddress(streetAddress: editedStreet));

      TransporterInfo callback;
      final onSaved = (TransporterInfo changed) => callback = changed;

      final fieldFinder = find.text(initialStreet);
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");

      await pumpTransporterInfoFormField(tester, testInfo, onSaved);
      // Edit text
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedStreet);
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });

    testWidgets(
        'calls onSaved with edited driver names when save button pressed',
        (WidgetTester tester) async {
      final initialNames = ["Jason Breve", "Jackson Night"];
      final editedNames = ["Jason Breve", "Jackson Night", "Andrea James"];
      final testInfo = testTransporterInfo(driverNames: initialNames);
      final expectedEditedInfo = testTransporterInfo(driverNames: editedNames);

      final addButtonFinder = find.byIcon(Icons.add);
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      final emptyDriverNameFieldFinder = find.widgetWithText(TextFormField, "");

      TransporterInfo callbackInfo;
      final onSavedCallback = (TransporterInfo info) => callbackInfo = info;

      await pumpTransporterInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(addButtonFinder);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      // Edit
      await tester.enterText(emptyDriverNameFieldFinder, "Andrea James");
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, expectedEditedInfo);
    });
  });
}
