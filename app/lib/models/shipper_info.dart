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
      this.shipperName,
      this.shipperIsAnimalOwner,
      this.departureLocationId,
      this.departureLocationName,
      this.departureAddress,
      this.shipperContactInfo);
}
