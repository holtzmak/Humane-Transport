import 'package:app/core/models/address.dart';
import 'package:app/ui/common/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  factory FeedWaterRestInfo.defaultFwrInfo() => FeedWaterRestInfo(
      lastFwrDate: DateTime.now(),
      lastFwrLocation: Address.defaultAddress(),
      fwrEvents: []);

  FeedWaterRestInfo.fromJSON(Map<String, dynamic> json)
      : lastFwrDate = json['lastFeedWaterRestDate'].toDate(),
        lastFwrLocation = Address.fromJSON(json['lastFeedWaterRestLocation']),
        _fwrEvents = json['feedWaterRestEvents']
            .map<FeedWaterRestEvent>(
                (fwrEvent) => FeedWaterRestEvent.fromJson(fwrEvent))
            .toList();

  Map<String, dynamic> toJSON() => {
        'lastFeedWaterRestDate': lastFwrDate,
        'lastFeedWaterRestLocation': lastFwrLocation.toJSON(),
        'feedWaterRestEvents':
            _fwrEvents.map((fwrEvent) => fwrEvent.toJSON()).toList(),
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
      \nDate and time: ${DateFormat("yyyy-MM-dd hh:mm").format(lastFwrDate)}, Place: $lastFwrLocation
      \nIf FWR was provided during transport: ${_fwrEventsToString()}''';

  List<Widget> _fwrEventsToWidget() => _fwrEvents.isEmpty
      ? [
          ListTile(
              title: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: NavyBlue)),
                  child: Text("N/A")))
        ]
      : _fwrEvents.map((event) => event.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          title: Text(
              "Last access to feed, water and rest (FWR) prior to loading")),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Date and time")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(
                  '${DateFormat("yyyy-MM-dd hh:mm").format(lastFwrDate)}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Place")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$lastFwrLocation'))),
      ListTile(title: Text("If FWR was provided during transport")),
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
        fwrTime = json['feedWaterRestTime'].toDate(),
        lastFwrLocation = Address.fromJSON(json['lastFeedWaterRestLocation']),
        fwrProvidedOnboard = json['feedWaterRestProvidedOnboard'];

  Map<String, dynamic> toJSON() => {
        'animalsWereUnloaded': animalsWereUnloaded,
        'feedWaterRestTime': fwrTime,
        'lastFeedWaterRestLocation': lastFwrLocation.toJSON(),
        'feedWaterRestProvidedOnboard': fwrProvidedOnboard,
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
      \nDate and time: ${DateFormat("yyyy-MM-dd hh:mm").format(fwrTime)}, Place: $lastFwrLocation
      \nProvided onboard?: ${fwrProvidedOnboard ? 'Yes' : 'No'}''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Animals unloaded?")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${animalsWereUnloaded ? 'Yes' : 'No'}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Date and time")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child:
                  Text('${DateFormat("yyyy-MM-dd hh:mm").format(fwrTime)}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Place")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$lastFwrLocation'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Provided onboard?")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${fwrProvidedOnboard ? 'Yes' : 'No'}'))),
    ]);
  }
}
