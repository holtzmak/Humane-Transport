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
