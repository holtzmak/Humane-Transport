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

  DeliveryInfo(this.recInfo, this.arrivalDate, this.arrivalTime,
      this._compromisedAnimals, this.additionalWelfareConcerns);

  List<CompromisedAnimal> compromisedAnimals() =>
      List.unmodifiable(_compromisedAnimals);
}
