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
}

@immutable
class CompromisedAnimal {
  final String animalDescription;
  final String measuresTakenToCareForAnimal;

  CompromisedAnimal(
      {@required this.animalDescription,
      @required this.measuresTakenToCareForAnimal});
}
