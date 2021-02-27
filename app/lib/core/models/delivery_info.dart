import 'package:app/core/models/receiver_info.dart';
import 'package:flutter/foundation.dart';
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

  @override
  int get hashCode =>
      recInfo.hashCode ^
      arrivalDateAndTime.hashCode ^
      _compromisedAnimals.hashCode ^
      additionalWelfareConcerns.hashCode;

  @override
  bool operator ==(other) {
    return (other is DeliveryInfo) &&
        other.recInfo == recInfo &&
        other.arrivalDateAndTime == arrivalDateAndTime &&
        listEquals(other.compromisedAnimals, _compromisedAnimals) &&
        other.additionalWelfareConcerns == additionalWelfareConcerns;
  }

  DeliveryInfo.fromJSON(Map<String, dynamic> json)
      : recInfo = ReceiverInfo.fromJson(json['receiverInfo']),
        arrivalDateAndTime =
            DateTime.parse(json['arrivalDateAndTime'].toString()),
        _compromisedAnimals = json['_compromisedAnimals']
            .map<CompromisedAnimal>(
                (compAnimal) => CompromisedAnimal.fromJSON(compAnimal))
            .toList(),
        additionalWelfareConcerns = json['additionalWelfareConcerns'];

  Map<String, dynamic> toJSON() => {
        'recInfo': recInfo.toJSON(),
        'arrivalDateAndTime': arrivalDateAndTime,
        '_compromisedAnimals': _compromisedAnimals
            .map((compAnimal) => compAnimal.toJSON())
            .toList(),
        'additionalWelfareConcerns': additionalWelfareConcerns,
      };

  List<CompromisedAnimal> get compromisedAnimals =>
      List.unmodifiable(_compromisedAnimals);

  List<Widget> _compromisedAnimalsToWidget() => _compromisedAnimals.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text('N/A'))
        ]
      : _compromisedAnimals.map((animals) => animals.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Date and time of arrival"),
          subtitle: Text(
              '${DateFormat("yyyy-MM-dd hh:mm").format(arrivalDateAndTime)}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("All animals arrived in good condition?"),
          subtitle: Text('${_compromisedAnimals.isEmpty ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Description of transport related conditions and actions taken to address prior to arrival")),
    ];
    final Widget welfareConcerns = ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        title: Text(
            "Additional animal welfare concerns for the consignee to be aware of ?"),
        subtitle: Text(additionalWelfareConcerns));

    fields.insert(0, recInfo.toWidget());
    fields.addAll(_compromisedAnimalsToWidget());
    fields.add(welfareConcerns);
    return Column(children: fields);
  }
}
