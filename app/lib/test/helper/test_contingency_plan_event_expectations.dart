import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/test/helper/test_contingency_activity_expectations.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyContingencyPlanEventShown(ContingencyPlanEvent infoExpected) {
  // Date and time are in separate fields
  expect(
      find.text(
          DateFormat('MMM d, yyyy').format(infoExpected.eventDateAndTime)),
      findsOneWidget);
  expect(find.text(DateFormat('HH:mm').format(infoExpected.eventDateAndTime)),
      findsOneWidget);
  infoExpected.producerContactsUsed
      .forEach((contact) => expect(find.text(contact), findsOneWidget));
  infoExpected.receiverContactsUsed
      .forEach((contact) => expect(find.text(contact), findsOneWidget));
  expect(find.text(infoExpected.disturbancesIdentified), findsOneWidget);
  infoExpected.activities
      .forEach((activity) => verifyContingencyActivityShown(activity));
  infoExpected.actionsTaken
      .forEach((action) => expect(find.text(action), findsOneWidget));
}
