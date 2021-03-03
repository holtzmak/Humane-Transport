import 'package:flutter/foundation.dart';
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

  List<FeedWaterRestEvent> get fwrEvents => List.unmodifiable(_fwrEvents);

  factory FeedWaterRestInfo.defaultFwrInfo(
          {DateTime lastFwrDate,
          Address lastFwrLocation,
          FeedWaterRestEvent fwrEvents}) =>
      FeedWaterRestInfo(
          lastFwrDate: lastFwrDate ?? DateTime.parse("2021-02-03 13:01"),
          lastFwrLocation: lastFwrLocation ?? Address.defaultAddress(),
          fwrEvents: fwrEvents ?? []);

  FeedWaterRestInfo.fromJSON(Map<String, dynamic> json)
      : lastFwrDate = json['lastFwrDate'].toDate(),
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

  @override
  int get hashCode =>
      lastFwrDate.hashCode ^ lastFwrLocation.hashCode ^ _fwrEvents.hashCode;

  @override
  bool operator ==(other) {
    return (other is FeedWaterRestInfo) &&
        other.lastFwrDate == lastFwrDate &&
        other.lastFwrLocation == lastFwrLocation &&
        listEquals(other.fwrEvents, _fwrEvents);
  }

  String _fwrEventsToString() => _fwrEvents.isEmpty
      ? 'No events occurred during transport'
      : _fwrEvents.map((event) => event.toString()).toList().join(",");

  String toString() =>
      '''Last access to feed, water and rest (FWR) prior to loading:
      Date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(lastFwrDate)}, Place: $lastFwrLocation
      If FWR was provided during transport: $_fwrEventsToString()''';

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
        fwrTime = json['fwrTime'].toDate(),
        lastFwrLocation = Address.fromJSON(json['lastFwrLocation']),
        fwrProvidedOnboard = json['fwrProvidedOnboard'];

  Map<String, dynamic> toJSON() => {
        'animalsWereUnloaded': animalsWereUnloaded,
        'fwrTime': fwrTime,
        'lastFwrLocation': lastFwrLocation.toJSON(),
        'fwrProvidedOnboard': fwrProvidedOnboard,
      };

  @override
  int get hashCode =>
      animalsWereUnloaded.hashCode ^
      fwrTime.hashCode ^
      lastFwrLocation.hashCode ^
      fwrProvidedOnboard.hashCode;

  @override
  bool operator ==(other) {
    return (other is FeedWaterRestEvent) &&
        other.animalsWereUnloaded == animalsWereUnloaded &&
        other.fwrTime == fwrTime &&
        other.lastFwrLocation == lastFwrLocation &&
        other.fwrProvidedOnboard == fwrProvidedOnboard;
  }

  String toString() =>
      '''Animals unloaded?: ${animalsWereUnloaded ? 'Yes' : 'No'}
      Date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(fwrTime)}, Place: $lastFwrLocation
      Provided onboard?: ${fwrProvidedOnboard ? 'Yes' : 'No'}''';

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
