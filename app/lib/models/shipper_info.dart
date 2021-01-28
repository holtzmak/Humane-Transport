import 'package:app/common/utilities/address.dart';
import 'package:flutter/material.dart';

@immutable
class ShipperInfo {
  final String shipperName;
  final bool shipperIsAnimalOwner;
  final String departureLocationId;
  final String departureLocationName;
  final Address departureAddress;
  final String shipperContactInfo;

  ShipperInfo(
      {@required String shipperName,
      @required bool shipperIsAnimalOwner,
      @required String departureLocationId,
      @required String departureLocationName,
      @required Address departureAddress,
      @required String shipperContactInfo})
      : shipperName = shipperName,
        shipperIsAnimalOwner = shipperIsAnimalOwner,
        departureLocationId = departureLocationId,
        departureLocationName = departureLocationName,
        departureAddress = departureAddress,
        shipperContactInfo = shipperContactInfo;
}
