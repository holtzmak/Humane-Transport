import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/test/helper/test_contingency_plan_event_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(ContingencyPlanInfo infoExpected) {
    expect(find.text(infoExpected.goalStatement), findsOneWidget);
    expect(find.text(infoExpected.communicationPlan), findsOneWidget);
    expect(find.text(infoExpected.expectedPrepProcess), findsOneWidget);
    expect(find.text(infoExpected.standardAnimalMonitoring), findsOneWidget);
    infoExpected.crisisContacts.forEach((contact) {
      expect(find.text(contact), findsOneWidget);
    });
    infoExpected.potentialHazards.forEach((hazard) {
      expect(find.text(hazard), findsOneWidget);
    });
    infoExpected.potentialSafetyActions.forEach((action) {
      expect(find.text(action), findsOneWidget);
    });
    infoExpected.contingencyEvents.forEach((event) {
      verifyContingencyPlanEventShown(event);
    });
  }

  Future<void> pumpContingencyPlanInfoFormField(
          WidgetTester tester,
          ContingencyPlanInfo testInfo,
          Function(ContingencyPlanInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: ContingencyPlanInfoFormField(
            initialInfo: testInfo, onSaved: callback),
      )))));

  group('Contingency Plan Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final contingencyPlanInfo = ContingencyPlanInfo(
          goalStatement: "To protect the world from devastation",
          communicationPlan: "To unite all evil within our nation",
          crisisContacts: ["Jessie", "James"],
          expectedPrepProcess: "To denounce the evils of truth and love",
          standardAnimalMonitoring: "To extend our reach to the stars above",
          potentialHazards: ["Meowth", "That's right!"],
          potentialSafetyActions: [
            "Team Rocket blasting off at the speed of light!"
          ],
          contingencyEvents: []);
      await pumpContingencyPlanInfoFormField(tester, contingencyPlanInfo, (_) {
        // Do nothing for test
      });
      verifyInformationIsShown(contingencyPlanInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpContingencyPlanInfoFormField(tester, testContingencyInfo(),
          (_) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testContingencyInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      ContingencyPlanInfo callbackInfo;
      final onSavedCallback = (ContingencyPlanInfo info) => callbackInfo = info;

      await pumpContingencyPlanInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets(
        'calls onSaved with edited contingency event when save button pressed',
        (WidgetTester tester) async {
      final testContact = "Jamie Foxx";
      final editedContact = "Meghan Foxx";
      ContingencyPlanInfo callback;
      final onSaved = (ContingencyPlanInfo changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testContact);
      final testInfo = testContingencyInfo(contingencyEvents: [
        testContingencyEvent(receiverContactsUsed: [testContact])
      ]);
      final editedInfo = testContingencyInfo(contingencyEvents: [
        testContingencyEvent(receiverContactsUsed: [editedContact])
      ]);
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");

      await pumpContingencyPlanInfoFormField(tester, testInfo, onSaved);
      // Edit text
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedContact);
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });
  });
}
