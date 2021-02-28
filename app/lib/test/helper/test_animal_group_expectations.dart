import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/test/helper/test_compromised_animal_expectations.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyAnimalGroupIsShown(AnimalGroup infoExpected) {
  expect(find.text(infoExpected.species), findsOneWidget);
  expect(find.text(infoExpected.groupAge.toString()), findsOneWidget);
  expect(find.text(infoExpected.approximateWeight.toString()), findsOneWidget);
  expect(find.text(infoExpected.animalPurpose), findsOneWidget);
  expect(find.text(infoExpected.numberAnimals.toString()), findsOneWidget);
  // DropDownButtonFormFields have the values offscreen, so both are present
  expect(find.text(infoExpected.animalsFitForTransport ? "Yes" : "No"),
      findsOneWidget);

  infoExpected.compromisedAnimals.forEach((animal) {
    verifyCompromisedAnimalInfoIsShown(animal);
  });
  infoExpected.specialNeedsAnimals.forEach((animal) {
    verifyCompromisedAnimalInfoIsShown(animal);
  });
}
