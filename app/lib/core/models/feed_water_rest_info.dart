import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'address.dart';

@immutable
class FeedWaterRestInfo {
  final DateTime lastFwrDate;
  final Address lastFwrLocation;
  final List<FeedWaterRestEvent> _fwrEvents;

  FeedWaterRestInfo(
      {@required this.lastFwrDate,
      @required this.lastFwrLocation,
      @required List<FeedWaterRestEvent> fwrEvents})
      : _fwrEvents = fwrEvents;

  List<FeedWaterRestEvent> fwrEvents() => List.unmodifiable(_fwrEvents);

  FeedWaterRestInfo.fromJSON(Map<String, dynamic> json)
      : lastFwrDate = DateTime.parse(json['lastFwrDate'].toString()),
        lastFwrLocation = Address.fromJSON(json['lastFwrLocation']),
        _fwrEvents = json['_fwrEvents']
            .map<FeedWaterRestEvent>(
                (fwrEvent) => FeedWaterRestEvent.fromJson(fwrEvent))
            .toList();

  Map<String, dynamic> toJSON() => {
        'lastFwrDate': lastFwrDate,
        'lastFwrLocation': lastFwrLocation.toJSON(),
        '_fwrEvents': _fwrEvents.map((fwrEvent) => fwrEvent.toJSON()).toList(),
      };

  List<Widget> _fwrEventsToWidget() => _fwrEvents.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text("N/A"))
        ]
      : _fwrEvents.map((event) => event.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Last access to feed, water and rest (FWR) prior to loading")),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Date and time"),
          subtitle:
              Text('${DateFormat("yyyy-MM-dd hh:mm").format(lastFwrDate)}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Place"),
          subtitle: Text('$lastFwrLocation')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("If FWR was provided during transport")),
    ];
    fields.addAll(_fwrEventsToWidget());
    return Column(children: fields);
  }
}

@immutable
class FeedWaterRestEvent {
  final bool animalsWereUnloaded;
  final DateTime fwrTime;
  final Address lastFwrLocation;
  final bool fwrProvidedOnboard;

  FeedWaterRestEvent(
      {@required this.animalsWereUnloaded,
      @required this.fwrTime,
      @required this.lastFwrLocation,
      @required this.fwrProvidedOnboard});

  FeedWaterRestEvent.fromJson(Map<String, dynamic> json)
      : animalsWereUnloaded = json['animalsWereUnloaded'],
        fwrTime = DateTime.parse(json['fwrTime'].toString()),
        lastFwrLocation = Address.fromJSON(json['lastFwrLocation']),
        fwrProvidedOnboard = json['fwrProvidedOnboard'];

  Map<String, dynamic> toJSON() => {
        'animalsWereUnloaded': animalsWereUnloaded,
        'fwrTime': fwrTime,
        'lastFwrLocation': lastFwrLocation.toJSON(),
        'fwrProvidedOnboard': fwrProvidedOnboard,
      };

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Animals unloaded?"),
          subtitle: Text('${animalsWereUnloaded ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Date and time"),
          subtitle: Text('${DateFormat("yyyy-MM-dd hh:mm").format(fwrTime)}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Place"),
          subtitle: Text('$lastFwrLocation')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Provided onboard?"),
          subtitle: Text('${fwrProvidedOnboard ? 'Yes' : 'No'}')),
    ]);
  }
}
