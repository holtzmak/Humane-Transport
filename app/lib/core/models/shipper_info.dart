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

  String toString() => '''Name: $shipperName
  The shipper is the owner of the animals loaded in the vehicle: ${shipperIsAnimalOwner ? 'Yes' : 'No'}
  Departure Premises Identification number (PID): $departureLocationId, Name: $departureLocationName
  Address: $departureAddress
  Shipper’s Contact information in case of emergency: $shipperContactInfo''';
}
