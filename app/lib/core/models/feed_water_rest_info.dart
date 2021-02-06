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

  String toString() =>
      '''Last access to feed, water and rest (FWR) prior to loading:
      Date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(lastFwrDate)}, Place: $lastFwrLocation''';
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

  String toString() =>
      '''Animals unloaded?: ${animalsWereUnloaded ? 'Yes' : 'No'}
      Date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(fwrTime)}, Place: $lastFwrLocation
      Provided onboard?: ${fwrProvidedOnboard ? 'Yes' : 'No'}''';
}
