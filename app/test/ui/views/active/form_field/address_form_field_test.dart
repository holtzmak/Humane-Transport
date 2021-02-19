import 'package:app/core/models/address.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/form_field/address_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(Address infoExpected) {
    expect(find.text(infoExpected.streetAddress), findsOneWidget);
    expect(find.text(infoExpected.city), findsOneWidget);
    expect(find.text(infoExpected.provinceOrState), findsOneWidget);
    expect(find.text(infoExpected.country), findsOneWidget);
    expect(find.text(infoExpected.postalCode), findsOneWidget);
  }

  Future<void> pumpAddressFormField(
          WidgetTester tester, AddressFormField widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: widget,
      )))));

  group('Address Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testAddr = Address(
          streetAddress: "Some st.",
          city: "Some city",
          provinceOrState: "Some state",
          country: "Some country",
          postalCode: "ABCXYZ");
      final widget = AddressFormField(initialAddr: testAddr);
      await pumpAddressFormField(tester, widget);
      verifyInformationIsShown(testAddr);
    });

    testWidgets('getAddress with info', (WidgetTester tester) async {
      final testAddr = testAddress();
      final widget = AddressFormField(initialAddr: testAddr);
      await pumpAddressFormField(tester, widget);
      expect(testAddr, widget.getAddress());
    });

    testWidgets('getAddress with edited info', (WidgetTester tester) async {
      final initialStreet = "ABC Street";
      final editedStreet = "ABC St.";
      final testAddr = testAddress(streetAddress: initialStreet);
      final expectedEditedInfo = testAddress(streetAddress: editedStreet);
      final streetAddressFinder =
          find.widgetWithText(TextFormField, initialStreet);

      final widget = AddressFormField(initialAddr: testAddr);
      await pumpAddressFormField(tester, widget);
      await tester.enterText(streetAddressFinder, editedStreet);
      expect(expectedEditedInfo, widget.getAddress());
    });
  });
}
