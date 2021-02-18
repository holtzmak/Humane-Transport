import 'package:app/core/models/address.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_lib/test_animal_transport_record.dart';

void main() {
  void verifyInformationIsShown(ShipperInfo infoExpected) {
    expect(find.text(infoExpected.shipperName), findsOneWidget);
    expect(find.text(infoExpected.shipperIsAnimalOwner ? "Yes" : "No"),
        findsOneWidget);
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

  Future<void> pumpShipperInfoFormField(WidgetTester tester,
          ShipperInfo testInfo, Function(ShipperInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: ShipperInfoFormField(initialInfo: testInfo, onSaved: callback),
      )))));

  group('Shipper Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
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
      await pumpShipperInfoFormField(tester, testShipperInfo,
          (ShipperInfo info) {
        // Do nothing for test
      });
      verifyInformationIsShown(testShipperInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpShipperInfoFormField(tester, testShipperInfo(),
          (ShipperInfo info) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testShipperInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      ShipperInfo callbackInfo;
      final onSavedCallback = (ShipperInfo info) => callbackInfo = info;

      await pumpShipperInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets('calls onSaved with edited info when save button pressed',
        (WidgetTester tester) async {});
  });
}
