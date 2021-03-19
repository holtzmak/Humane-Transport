import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/test/helper/test_animal_group_expectations.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/animal_group_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  Future<void> pumpAnimalGroupFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: widget,
      )))));

  group('Animal Group Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final testAnimalGroup = AnimalGroup(
          species: "Cattle",
          groupAge: 5,
          approximateWeight: 1800,
          animalPurpose: "Going to vet for checkup",
          numberAnimals: 8,
          animalsFitForTransport: true,
          compromisedAnimals: [],
          specialNeedsAnimals: [
            CompromisedAnimal(
                animalDescription: "Black, small cow has neurological problems",
                measuresTakenToCareForAnimal:
                    "Rendered cow unconscious for travel")
          ]);
      final widget = AnimalGroupFormField(
        initial: testAnimalGroup,
        onSaved: (_) {
          // Do nothing for test
        },
        onDelete: () {
          // Do nothing for test
        },
      );
      await pumpAnimalGroupFormField(tester, widget);
      verifyAnimalGroupIsShown(testAnimalGroup);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = AnimalGroupFormField(
        initial: testAnimalGroup(),
        onSaved: (_) {
          // Do nothing for test
        },
        onDelete: onDeleteCallback,
      );
      await pumpAnimalGroupFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets(
        'onSaved called with edited special needs animal info when changed',
        (WidgetTester tester) async {
      final testDescription = "Small black horse";
      final editedDescription = "Piebald horse";
      final testInfo = testAnimalGroup(specialNeedsAnimals: [
        testCompromisedAnimal(animalDescription: testDescription)
      ]);
      final editedInfo = testAnimalGroup(specialNeedsAnimals: [
        testCompromisedAnimal(animalDescription: editedDescription)
      ]);
      AnimalGroup callback;
      final onSaved = (AnimalGroup changed) => callback = changed;
      final fieldFinder = find.text(testDescription);
      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: AnimalGroupFormField(
            initial: testInfo,
            onSaved: onSaved,
            onDelete: () {
              // Do nothing for test
            },
          ));
      await pumpAnimalGroupFormField(tester, widget);
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedDescription);
      await tester.pumpAndSettle();
      formKey.currentState.save();
      expect(callback, editedInfo);
    });
  });
}
