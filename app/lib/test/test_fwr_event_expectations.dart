import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/test/test_address_expectations.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyFwrEventInformationIsShown(FeedWaterRestEvent infoExpected) {
  // DropDownButtonFormFields have the values offscreen, so both are present
  // TODO: Make expectations for DropDownButtonFormFields

  // Date and time are in separate fields
  expect(find.text(DateFormat('MMM d, yyyy').format(infoExpected.fwrTime)),
      findsOneWidget);
  expect(find.text(DateFormat('HH:mm').format(infoExpected.fwrTime)),
      findsOneWidget);

  verifyAddressIsShown(infoExpected.lastFwrLocation);
}
