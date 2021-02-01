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
      {@required ReceiverInfo recInfo,
      @required DateTime arrivalDate,
      @required List<CompromisedAnimal> compromisedAnimals,
      @required String additionalWelfareConcerns})
      : recInfo = recInfo,
        arrivalDateAndTime = arrivalDate,
        _compromisedAnimals = compromisedAnimals,
        additionalWelfareConcerns = additionalWelfareConcerns;

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);
}
