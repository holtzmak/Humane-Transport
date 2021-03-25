import 'package:app/ui/common/style.dart';
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

  factory ShipperInfo.defaultShipperInfo() => ShipperInfo(
      shipperName: "",
      shipperIsAnimalOwner: false,
      departureLocationId: "",
      departureLocationName: "",
      departureAddress: Address.defaultAddress(),
      shipperContactInfo: "");

  ShipperInfo.fromJSON(Map<String, dynamic> json)
      : shipperName = json['shipperName'],
        shipperIsAnimalOwner = json['shipperIsAnimalOwner'],
        departureLocationId = json['departureLocationId'],
        departureLocationName = json['departureLocationName'],
        departureAddress = Address.fromJSON(json['departureAddress']),
        shipperContactInfo = json['shipperContactInfo'];

  Map<String, dynamic> toJSON() => {
        'shipperName': shipperName,
        'shipperIsAnimalOwner': shipperIsAnimalOwner,
        'departureLocationId': departureLocationId,
        'departureLocationName': departureLocationName,
        'departureAddress': departureAddress.toJSON(),
        'shipperContactInfo': shipperContactInfo,
      };

  @override
  int get hashCode =>
      shipperName.hashCode ^
      shipperIsAnimalOwner.hashCode ^
      departureLocationId.hashCode ^
      departureLocationName.hashCode ^
      departureAddress.hashCode ^
      shipperContactInfo.hashCode;

  @override
  bool operator ==(other) {
    return (other is ShipperInfo) &&
        other.shipperName == shipperName &&
        other.shipperIsAnimalOwner == shipperIsAnimalOwner &&
        other.departureLocationId == departureLocationId &&
        other.departureAddress == departureAddress &&
        other.shipperContactInfo == shipperContactInfo;
  }

  String toString() => '''Name: $shipperName
  \nThe shipper is the owner of the animals loaded in the vehicle?: ${shipperIsAnimalOwner ? 'Yes' : 'No'}
  \nDeparture Premises Identification number (PID): $departureLocationId,\nLocation Name: $departureLocationName
  \nAddress: $departureAddress
  \nShipper's Contact information in case of emergency: $shipperContactInfo''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Name")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(shipperName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "The shipper is the owner of the animals loaded in the vehicle")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${shipperIsAnimalOwner ? 'Yes' : 'No'}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Departure Premises Identification number (PID)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(departureLocationId))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Name")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(departureLocationName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Address")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$departureAddress'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:
                  Text("Shipper’s Contact information in case of emergency")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(shipperContactInfo))),
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
      ),
    ]);
  }
}
