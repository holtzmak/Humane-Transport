import 'package:flutter/material.dart';

@immutable
class LoadingVehicleInfo {
  final DateTime dateLoaded;
  final TimeOfDay timeLoaded;
  final int loadingArea;
  final int loadingDensity;
  final int animalsPerLoadingArea;
  final List<AnimalGroup> _animalsLoaded;

  LoadingVehicleInfo(
      {@required DateTime dateLoaded,
      @required TimeOfDay timeLoaded,
      @required int loadingArea,
      @required int loadingDensity,
      @required int animalsPerLoadingArea,
      @required List<AnimalGroup> animalsLoaded})
      : dateLoaded = dateLoaded,
        timeLoaded = timeLoaded,
        loadingArea = loadingArea,
        loadingDensity = loadingDensity,
        animalsPerLoadingArea = animalsPerLoadingArea,
        _animalsLoaded = animalsLoaded;

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
      {@required String species,
      @required int groupAge,
      @required int approximateWeight,
      @required String animalPurpose,
      @required int numberAnimals,
      @required bool animalsFitForTransport,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required List<CompromisedAnimal> specialNeedsAnimals})
      : species = species,
        groupAge = groupAge,
        approximateWeight = approximateWeight,
        animalPurpose = animalPurpose,
        numberAnimals = numberAnimals,
        animalsFitForTransport = animalsFitForTransport,
        _compromisedAnimals = compromisedAnimals,
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
      {@required String animalDescription,
      @required String measuresTakenToCareForAnimal})
      : animalDescription = animalDescription,
        measuresTakenToCareForAnimal = measuresTakenToCareForAnimal;
}
