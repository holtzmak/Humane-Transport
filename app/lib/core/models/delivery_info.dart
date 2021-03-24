import 'package:app/core/models/receiver_info.dart';
import 'package:app/ui/common/style.dart';
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

  factory DeliveryInfo.defaultDeliveryInfo() => DeliveryInfo(
      recInfo: ReceiverInfo.defaultReceiverInfo(),
      arrivalDateAndTime: DateTime.now(),
      compromisedAnimals: [],
      additionalWelfareConcerns: "");

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
        arrivalDateAndTime = json['arrivalDateAndTime'].toDate(),
        _compromisedAnimals = json['compromisedAnimals']
            .map<CompromisedAnimal>(
                (compAnimal) => CompromisedAnimal.fromJSON(compAnimal))
            .toList(),
        additionalWelfareConcerns = json['additionalWelfareConcerns'];

  Map<String, dynamic> toJSON() => {
        'receiverInfo': recInfo.toJSON(),
        'arrivalDateAndTime': arrivalDateAndTime,
        'compromisedAnimals': _compromisedAnimals
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
              title: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: NavyBlue)),
                  child: Text('N/A')))
        ]
      : _compromisedAnimals.map((animals) => animals.toWidget()).toList();

  String _compromisedAnimalsToString() => _compromisedAnimals.isEmpty
      ? 'N/A'
      : _compromisedAnimals
          .map((animal) => animal.toString())
          .toList()
          .join(",");

  String toString() => '''$recInfo
  \nDate and time of arrival: ${DateFormat("yyyy-MM-dd hh:mm").format(arrivalDateAndTime)}
  \nAll animals arrived in good condition?: ${_compromisedAnimals.isEmpty ? 'Yes' : 'No'}
  \nDescription of transport related conditions and actions taken to address prior to arrival: ${_compromisedAnimalsToString()}
  \nAdditional animal welfare concerns for the consignee to be aware of?: $additionalWelfareConcerns''';

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Date and time of arrival")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(
                  '${DateFormat("yyyy-MM-dd hh:mm").format(arrivalDateAndTime)}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("All animals arrived in good condition?")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_compromisedAnimals.isEmpty ? 'Yes' : 'No'}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Description of transport related conditions and actions taken to address prior to arrival"))),
    ];
    final Widget welfareConcerns = ListTile(
        title: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
                "Additional animal welfare concerns for the consignee to be aware of ?")),
        subtitle: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
            child: Text(additionalWelfareConcerns)));

    fields.insert(0, recInfo.toWidget());
    fields.addAll(_compromisedAnimalsToWidget());
    fields.add(welfareConcerns);
    fields.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0),
    ));
    return Column(children: fields);
  }
}
