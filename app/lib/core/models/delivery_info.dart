import 'package:app/core/models/receiver_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String _compromisedAnimalsToString() => _compromisedAnimals.isEmpty
      ? 'N/A'
      : _compromisedAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String toString() => '''$recInfo
  Date and time of arrival: ${DateFormat("yyyy-MM-dd hh:mm").format(arrivalDateAndTime)}
  All animals arrived in good condition?: ${_compromisedAnimals.isEmpty ? 'Yes' : 'No'}
  Description of transport related conditions and actions taken to address prior to arrival: ${_compromisedAnimalsToString()}
  Additional animal welfare concerns for the consignee to be aware of ?: $additionalWelfareConcerns''';
}
