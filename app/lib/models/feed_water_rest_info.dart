import 'package:app/common/utilities/address.dart';
import 'package:flutter/material.dart';

@immutable
class FeedWaterRestInfo {
  final DateTime lastFwrDate;
  final Address lastFwrLocation;
  final List<FeedWaterRestEvent> _fwrEvents;

  FeedWaterRestInfo(this.lastFwrDate, this.lastFwrLocation, this._fwrEvents);

  List<FeedWaterRestEvent> fwrEvents() => List.unmodifiable(_fwrEvents);
}

@immutable
class FeedWaterRestEvent {
  final bool animalsWereUnloaded;
  final DateTime fwrTime;
  final Address lastFwrLocation;
  final bool fwrProvidedOnboard;

  FeedWaterRestEvent(this.animalsWereUnloaded, this.fwrTime,
      this.lastFwrLocation, this.fwrProvidedOnboard);
}
