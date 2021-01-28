import 'package:app/common/utilities/address.dart';
import 'package:flutter/material.dart';

@immutable
class FeedWaterRestInfo {
  final DateTime lastFwrDate;
  final Address lastFwrLocation;
  final List<FeedWaterRestEvent> _fwrEvents;

  FeedWaterRestInfo(
      {@required DateTime lastFwrDate,
      @required Address lastFwrLocation,
      @required List<FeedWaterRestEvent> fwrEvents})
      : lastFwrDate = lastFwrDate,
        lastFwrLocation = lastFwrLocation,
        _fwrEvents = fwrEvents;

  List<FeedWaterRestEvent> fwrEvents() => List.unmodifiable(_fwrEvents);
}

@immutable
class FeedWaterRestEvent {
  final bool animalsWereUnloaded;
  final DateTime fwrTime;
  final Address lastFwrLocation;
  final bool fwrProvidedOnboard;

  FeedWaterRestEvent(
      {@required bool animalsWereUnloaded,
      @required DateTime fwrTime,
      @required Address lastFwrLocation,
      @required bool fwrProvidedOnboard})
      : animalsWereUnloaded = animalsWereUnloaded,
        fwrTime = fwrTime,
        lastFwrLocation = lastFwrLocation,
        fwrProvidedOnboard = fwrProvidedOnboard;
}
