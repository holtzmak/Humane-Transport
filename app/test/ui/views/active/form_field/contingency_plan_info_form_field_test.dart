import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/test/helper/test_contingency_plan_event_expectations.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

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
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: widget,
      )))));

  group('Contingency Plan Info Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

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
      final widget = ContingencyPlanInfoFormField(
          initialInfo: contingencyPlanInfo,
          onSaved: (_) {
            // Do nothing for test
          });
      await pumpContingencyPlanInfoFormField(tester, widget);
      verifyInformationIsShown(contingencyPlanInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      final widget = ContingencyPlanInfoFormField(
          initialInfo: testContingencyInfo(),
          onSaved: (_) {
            // Do nothing for test
          });
      await pumpContingencyPlanInfoFormField(tester, widget);
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testContingencyInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      ContingencyPlanInfo callbackInfo;
      final onSavedCallback = (ContingencyPlanInfo info) => callbackInfo = info;

      final widget = ContingencyPlanInfoFormField(
          initialInfo: testInfo, onSaved: onSavedCallback);
      await pumpContingencyPlanInfoFormField(tester, widget);
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

      final widget =
          ContingencyPlanInfoFormField(initialInfo: testInfo, onSaved: onSaved);
      await pumpContingencyPlanInfoFormField(tester, widget);
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
