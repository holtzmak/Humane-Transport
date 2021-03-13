import 'package:app/core/models/contingency_plan_info.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyContingencyActivityShown(ContingencyActivity infoExpected) {
  expect(
      find.text(DateFormat('HH:mm').format(infoExpected.time)), findsOneWidget);
  expect(find.text(infoExpected.personContacted), findsOneWidget);
  expect(find.text(infoExpected.methodOfContact), findsOneWidget);
  expect(find.text(infoExpected.instructionsGiven), findsOneWidget);
}
