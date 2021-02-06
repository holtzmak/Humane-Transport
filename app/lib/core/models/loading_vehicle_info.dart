import 'package:flutter/material.dart';

@immutable
class LoadingVehicleInfo {
  final DateTime dateAndTimeLoaded;
  final int loadingArea;
  final int loadingDensity;
  final int animalsPerLoadingArea;
  final List<AnimalGroup> _animalsLoaded;

  LoadingVehicleInfo(
      {@required this.dateAndTimeLoaded,
      @required this.loadingArea,
      @required this.loadingDensity,
      @required this.animalsPerLoadingArea,
      @required List<AnimalGroup> animalsLoaded})
      : _animalsLoaded = animalsLoaded;

  List<AnimalGroup> animalsLoaded() => List.unmodifiable(_animalsLoaded);

  List<String> animalSpeciesLoaded() {
    return List.unmodifiable(
        _animalsLoaded.map((animalGroup) => animalGroup.species).toList());
  }
}

@immutable
class AnimalGroup {
  final String species;
  final int groupAge;
  final int approximateWeight;
  final String animalPurpose;
  final int numberAnimals;
  final bool animalsFitForTransport;
  final List<CompromisedAnimal> _compromisedAnimals;
  final List<CompromisedAnimal> _specialNeedsAnimals;

  AnimalGroup(
      {@required this.species,
      @required this.groupAge,
      @required this.approximateWeight,
      @required this.animalPurpose,
      @required this.numberAnimals,
      @required this.animalsFitForTransport,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required List<CompromisedAnimal> specialNeedsAnimals})
      : _compromisedAnimals = compromisedAnimals,
        _specialNeedsAnimals = specialNeedsAnimals;

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);

  List<CompromisedAnimal> specialNeedsAnimals() =>
      List.unmodifiable(_specialNeedsAnimals);

  String _compromisedAnimalsToString() => _compromisedAnimals.isEmpty
      ? 'N/A'
      : _compromisedAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String _specialNeedsAnimalsToString() => _specialNeedsAnimals.isEmpty
      ? 'N/A'
      : _specialNeedsAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String toString() => '''Animal(s) description:
  Species: $species, Group age: $groupAge, Approximate weight: $approximateWeight
  Purpose: $animalPurpose, Number of animals: $numberAnimals
  Are all animals fit for transport: ${animalsFitForTransport ? 'Yes' : 'No'}
  Number of compromised animals loaded: ${_compromisedAnimals.length}
  Compromised animal(s), identification description and measures taken: ${_compromisedAnimalsToString()}
  Number of animal(s) with special needs: ${_specialNeedsAnimals.length}
  Special needs animal(s), identification description and measures taken: ${_specialNeedsAnimalsToString()}''';
}

@immutable
class CompromisedAnimal {
  final String animalDescription;
  final String measuresTakenToCareForAnimal;

  CompromisedAnimal(
      {@required this.animalDescription,
      @required this.measuresTakenToCareForAnimal});

  String toString() => '''$animalDescription
  $measuresTakenToCareForAnimal
  ''';
}
