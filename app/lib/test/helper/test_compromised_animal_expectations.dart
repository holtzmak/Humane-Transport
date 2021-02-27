import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:flutter_test/flutter_test.dart';

void verifyCompromisedAnimalInfoIsShown(CompromisedAnimal infoExpected) {
  expect(find.text(infoExpected.animalDescription), findsOneWidget);
  expect(find.text(infoExpected.measuresTakenToCareForAnimal), findsOneWidget);
}
