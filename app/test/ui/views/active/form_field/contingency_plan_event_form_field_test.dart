import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/test/helper/test_contingency_plan_event_expectations.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  Future<void> pumpContingencyPlanEventFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
        child: widget,
      ))));

  group('Contingency Plan Event Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final contingencyEvent = ContingencyPlanEvent(
          eventDateAndTime: DateTime.parse("2020-01-01 19:32"),
          producerContactsUsed: ["Phone"],
          receiverContactsUsed: ["Text"],
          disturbancesIdentified: "Cow was bleeding heavily",
          activities: [testContingencyActivity()],
          actionsTaken: ["Bandaged up cow"]);
      final widget = ContingencyPlanEventFormField(
        initial: contingencyEvent,
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: () {
          // do nothing for test
        },
      );
      await pumpContingencyPlanEventFormField(tester, widget);
      verifyContingencyPlanEventShown(contingencyEvent);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete).first;
      final widget = ContingencyPlanEventFormField(
        initial: testContingencyEvent(),
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: onDeleteCallback,
      );
      await pumpContingencyPlanEventFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets('onSaved called when contingency activity edited and saved',
        (WidgetTester tester) async {
      final testContact = "Jamie Foxx";
      final editedContact = "Meghan Foxx";
      ContingencyPlanEvent callback;
      final onSavedCallback =
          (ContingencyPlanEvent changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testContact);
      final editedFieldFinder =
          find.widgetWithText(TextFormField, editedContact);
      final testEvent = testContingencyEvent(
          activities: [testContingencyActivity(personContacted: testContact)]);
      final editedEvent = testContingencyEvent(activities: [
        testContingencyActivity(personContacted: editedContact)
      ]);
      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: ContingencyPlanEventFormField(
            initial: testEvent,
            onSaved: onSavedCallback,
            onDelete: () {
              // do nothing for test
            },
          ));
      await pumpContingencyPlanEventFormField(tester, widget);
      await tester.enterText(fieldFinder, editedContact);
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedEvent);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
