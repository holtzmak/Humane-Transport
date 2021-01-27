import 'package:flutter/material.dart';

@immutable
class LoadingVehicleInfo {
  final DateTime dateLoaded;
  final TimeOfDay timeLoaded;
  final int loadingArea;
  final int loadingDensity;
  final int animalsPerLoadingArea;
  final List<AnimalGroup> _animalsLoaded;

  LoadingVehicleInfo(this.dateLoaded, this.timeLoaded, this.loadingArea,
      this.loadingDensity, this.animalsPerLoadingArea, this._animalsLoaded);

  List<AnimalGroup> animalsLoaded() => List.unmodifiable(_animalsLoaded);
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
      this.species,
      this.groupAge,
      this.approximateWeight,
      this.animalPurpose,
      this.numberAnimals,
      this.animalsFitForTransport,
      this._compromisedAnimals,
      this._specialNeedsAnimals);

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);

  List<CompromisedAnimal> specialNeedsAnimals() =>
      List.unmodifiable(_specialNeedsAnimals);
}

@immutable
class CompromisedAnimal {
  final String animalDescription;
  final String measuresTakenToCareForAnimal;

  CompromisedAnimal(this.animalDescription, this.measuresTakenToCareForAnimal);
}
