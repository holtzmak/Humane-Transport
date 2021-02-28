import 'package:app/core/models/receiver_info.dart';
import 'package:app/test/helper/test_address_expectations.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyReceiverInfoIsShown(ReceiverInfo infoExpected) {
  expect(find.text(infoExpected.receiverCompanyName), findsOneWidget);
  expect(find.text(infoExpected.receiverName), findsOneWidget);
  expect(
      find.text(infoExpected.accountId.isPresent()
          ? infoExpected.accountId.get()
          : ""),
      findsOneWidget);
  expect(find.text(infoExpected.destinationLocationId), findsOneWidget);
  expect(find.text(infoExpected.destinationLocationName), findsOneWidget);
  expect(find.text(infoExpected.receiverContactInfo), findsOneWidget);

  verifyAddressIsShown(infoExpected.destinationAddress);
}
