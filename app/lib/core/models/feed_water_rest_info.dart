import 'package:flutter/material.dart';

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
}
