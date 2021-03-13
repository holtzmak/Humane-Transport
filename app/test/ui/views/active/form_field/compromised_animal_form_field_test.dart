import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/test/helper/test_compromised_animal_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/compromised_animal_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCompromisedAnimalFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

  group('Compromised Animal Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final compromisedAnimal = CompromisedAnimal(
          animalDescription: "Chicken with bad leg",
          measuresTakenToCareForAnimal:
              "Wrapped the leg in bandages and stint");
      final widget = CompromisedAnimalFormField(
          title: "Compromised Animal",
          initial: compromisedAnimal,
          onSaved: (_) {
            // do nothing for test
          },
          onDelete: () {
            // do nothing for test
          });
      await pumpCompromisedAnimalFormField(tester, widget);
      verifyCompromisedAnimalInfoIsShown(compromisedAnimal);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = CompromisedAnimalFormField(
          title: "Compromised Animal",
          initial: testCompromisedAnimal(),
          onSaved: (_) {
            // do nothing for test
          },
          onDelete: onDeleteCallback);
      await pumpCompromisedAnimalFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets('onSaved called when edited and saved',
        (WidgetTester tester) async {
      final testDescription = "Chicken bad leg";
      final editedDescription = "Turkey bad leg";
      CompromisedAnimal callback;
      final onSavedCallback = (CompromisedAnimal changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testDescription);
      final editedFieldFinder =
          find.widgetWithText(TextFormField, editedDescription);
      final testAnimal =
          testCompromisedAnimal(animalDescription: testDescription);
      final editedCompromisedAnimal =
          testCompromisedAnimal(animalDescription: editedDescription);
      final formKey = GlobalKey<FormState>();
      final widget = Form(
        key: formKey,
        child: CompromisedAnimalFormField(
            title: "Compromised Animal",
            initial: testAnimal,
            onSaved: onSavedCallback,
            onDelete: () {
              // do nothing for test
            }),
      );
      await pumpCompromisedAnimalFormField(tester, widget);
      await tester.enterText(fieldFinder, editedDescription);
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedCompromisedAnimal);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
