import 'package:flutter/material.dart';
import 'address.dart';

@immutable
class ShipperInfo {
  final String shipperName;
  final bool shipperIsAnimalOwner;
  final String departureLocationId;
  final String departureLocationName;
  final Address departureAddress;
  final String shipperContactInfo;

  ShipperInfo(
      {@required this.shipperName,
      @required this.shipperIsAnimalOwner,
      @required this.departureLocationId,
      @required this.departureLocationName,
      @required this.departureAddress,
      @required this.shipperContactInfo});
}
