import 'package:app/core/models/address.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyAddressIsShown(Address infoExpected) {
  expect(find.text(infoExpected.streetAddress), findsOneWidget);
  expect(find.text(infoExpected.city), findsOneWidget);
  expect(find.text(infoExpected.provinceOrState), findsOneWidget);
  expect(find.text(infoExpected.country), findsOneWidget);
  expect(find.text(infoExpected.postalCode), findsOneWidget);
}
