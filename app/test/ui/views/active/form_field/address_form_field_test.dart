import 'package:app/core/models/address.dart';
import 'package:app/test/helper/test_address_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/address_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAddressFormField(
          WidgetTester tester, AddressFormField widget) async =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

  group('Address Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testAddr = Address(
          streetAddress: "Some st.",
          city: "Some city",
          provinceOrState: "Some state",
          country: "Some country",
          postalCode: "ABCXYZ");
      final widget = AddressFormField(
        initialAddr: testAddr,
        onSaved: (Address _) {
          // do nothing for test
        },
      );
      await pumpAddressFormField(tester, widget);
      verifyAddressIsShown(testAddr);
    });

    testWidgets('onSaved called when info is edited',
        (WidgetTester tester) async {
      final initialStreet = "ABC Street";
      final editedStreet = "Edited Street";
      final testAddr = testAddress(streetAddress: initialStreet);
      final editedAddr = testAddress(streetAddress: editedStreet);
      Address callback;
      final onSaved = (Address changed) => callback = changed;
      final fieldFinder = find.text(initialStreet);
      final widget = AddressFormField(
        initialAddr: testAddr,
        onSaved: onSaved,
      );
      await pumpAddressFormField(tester, widget);
      await tester.enterText(fieldFinder, editedStreet);
      await tester.pumpAndSettle();
      expect(callback, editedAddr);
    });
  });
}
