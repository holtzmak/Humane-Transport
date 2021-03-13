import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/test/helper/test_contingency_activity_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/contingency_activity_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpContingencyActivityFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

  group('Contingency Activity Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final contingencyActivity = ContingencyActivity(
          time: DateTime.parse("1970-01-01 19:22"),
          personContacted: "Jamie Hill",
          methodOfContact: "Phone call",
          instructionsGiven: "Wait for authorities to arrive");
      final widget = ContingencyActivityFormField(
        initial: contingencyActivity,
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: () {
          // do nothing for test
        },
      );
      await pumpContingencyActivityFormField(tester, widget);
      verifyContingencyActivityShown(contingencyActivity);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = ContingencyActivityFormField(
        initial: testContingencyActivity(),
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: onDeleteCallback,
      );
      await pumpContingencyActivityFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets('onSaved called when edited and saved',
        (WidgetTester tester) async {
      final testContact = "Jamie Foxx";
      final editedContact = "Meghan Foxx";
      ContingencyActivity callback;
      final onSavedCallback =
          (ContingencyActivity changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testContact);
      final editedFieldFinder =
          find.widgetWithText(TextFormField, editedContact);
      final testActivity =
          testContingencyActivity(personContacted: testContact);
      final editedActivity =
          testContingencyActivity(personContacted: editedContact);
      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: ContingencyActivityFormField(
            initial: testActivity,
            onSaved: onSavedCallback,
            onDelete: () {
              // do nothing for test
            },
          ));
      await pumpContingencyActivityFormField(tester, widget);
      await tester.enterText(fieldFinder, editedContact);
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedActivity);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
