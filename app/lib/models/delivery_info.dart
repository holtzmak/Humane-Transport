import 'package:app/models/loading_vehicle_info.dart';
import 'package:app/models/receiver_info.dart';
import 'package:flutter/material.dart';

@immutable
class DeliveryInfo {
  final ReceiverInfo recInfo;
  final DateTime arrivalDate;
  final TimeOfDay arrivalTime;
  final List<CompromisedAnimal> _compromisedAnimals;
  final String additionalWelfareConcerns;

  DeliveryInfo(
      {@required ReceiverInfo recInfo,
      @required DateTime arrivalDate,
      @required TimeOfDay arrivalTime,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required String additionalWelfareConcerns})
      : recInfo = recInfo,
        arrivalDate = arrivalDate,
        arrivalTime = arrivalTime,
        _compromisedAnimals = compromisedAnimals,
        additionalWelfareConcerns = additionalWelfareConcerns;

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);
}
