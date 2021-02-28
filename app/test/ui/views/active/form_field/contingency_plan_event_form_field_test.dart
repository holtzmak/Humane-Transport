import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/test/helper/test_contingency_plan_event_expectations.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpContingencyPlanEventFormField(
          WidgetTester tester,
          ContingencyPlanEvent initial,
          Function(ContingencyPlanEvent) onSaved,
          Function() onDelete) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
        child: ContingencyPlanEventFormField(
          initial: initial,
          onSaved: onSaved,
          onDelete: onDelete,
        ),
      ))));

  group('Contingency Plan Event Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final contingencyEvent = ContingencyPlanEvent(
          eventDateAndTime: DateTime.parse("2020-01-01 19:32"),
          producerContactsUsed: ["Phone"],
          receiverContactsUsed: ["Text"],
          disturbancesIdentified: "Cow was bleeding heavily",
          activities: [testContingencyActivity()],
          actionsTaken: ["Bandaged up cow"]);
      await pumpContingencyPlanEventFormField(tester, contingencyEvent, (_) {
        // do nothing for test
      }, () {
        // do nothing for test
      });
      verifyContingencyPlanEventShown(contingencyEvent);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete).first;
      await pumpContingencyPlanEventFormField(tester, testContingencyEvent(),
          (_) {
        // do nothing for test
      }, onDeleteCallback);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets('onSaved called when contingency activity edited',
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

      await pumpContingencyPlanEventFormField(
          tester, testEvent, onSavedCallback, () {
        // do nothing for test
      });
      await tester.enterText(fieldFinder, editedContact);
      await tester.pumpAndSettle();
      // expect was saved
      expect(callback, editedEvent);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
