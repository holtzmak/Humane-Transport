import 'package:app/core/models/receiver_info.dart';
import 'package:flutter/material.dart';

import 'loading_vehicle_info.dart';

@immutable
class DeliveryInfo {
  final ReceiverInfo recInfo;
  final DateTime arrivalDateAndTime;
  final List<CompromisedAnimal> _compromisedAnimals;
  final String additionalWelfareConcerns;

  DeliveryInfo(
      {@required this.recInfo,
      @required this.arrivalDateAndTime,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required this.additionalWelfareConcerns})
      : _compromisedAnimals = compromisedAnimals;

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);
}
