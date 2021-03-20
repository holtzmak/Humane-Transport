import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/common/style.dart';
import 'package:flutter/material.dart';

import 'address.dart';

@immutable
class ReceiverInfo {
  final String receiverCompanyName;
  final String receiverName;
  final Optional<String> accountId;
  final String destinationLocationId;
  final String destinationLocationName;
  final Address destinationAddress;
  final String receiverContactInfo;

  ReceiverInfo(
      {@required this.receiverCompanyName,
      @required this.receiverName,
      @required this.accountId,
      @required this.destinationLocationId,
      @required this.destinationLocationName,
      @required this.destinationAddress,
      @required this.receiverContactInfo});

  factory ReceiverInfo.defaultReceiverInfo() => ReceiverInfo(
      receiverCompanyName: "",
      receiverName: "",
      accountId: Optional.empty(),
      destinationLocationId: "",
      destinationLocationName: "",
      destinationAddress: Address.defaultAddress(),
      receiverContactInfo: "");

  @override
  int get hashCode =>
      receiverCompanyName.hashCode ^
      receiverName.hashCode ^
      accountId.hashCode ^
      destinationLocationId.hashCode ^
      destinationLocationName.hashCode ^
      destinationAddress.hashCode ^
      receiverContactInfo.hashCode;

  @override
  bool operator ==(other) {
    return (other is ReceiverInfo) &&
        other.receiverCompanyName == receiverCompanyName &&
        other.receiverName == receiverName &&
        other.accountId == accountId &&
        other.destinationLocationId == destinationLocationId &&
        other.destinationLocationName == destinationLocationName &&
        other.receiverContactInfo == receiverContactInfo &&
        other.destinationAddress == destinationAddress;
  }

  ReceiverInfo.fromJson(Map<String, dynamic> json)
      : receiverCompanyName = json['receiverCompanyName'],
        receiverName = json['receiverName'],
        accountId = Optional.ofNullable(json['accountId']),
        destinationLocationId = json['destinationLocationId'],
        destinationLocationName = json['destinationLocationName'],
        destinationAddress = Address.fromJSON(json['destinationAddress']),
        receiverContactInfo = json['receiverContactInfo'];

  Map<String, dynamic> toJSON() => {
        'receiverCompanyName': receiverCompanyName,
        'receiverName': receiverName,
        'accountId': accountId.isPresent() ? accountId.get() : null,
        'destinationLocationId': destinationLocationId,
        'destinationLocationName': destinationLocationName,
        'destinationAddress': destinationAddress.toJSON(),
        'receiverContactInfo': receiverContactInfo
      };

  String toString() => '''Receiving company name: $receiverCompanyName
  Representative name: $receiverName
  Account identification number (Optional): ${accountId.isPresent() ? accountId.get() : "N/A"}
  Destination and Premises Identification number (PID): $destinationLocationId, Name: $destinationLocationName
  Address: $destinationAddress
  Receiver’s Contact number in case of emergency: $receiverContactInfo''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Receiving company name")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(receiverCompanyName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Representative name")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(receiverName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Account identification number of the consignee in the database of the responsible administrator (Optional)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child:
                  Text('${accountId.isPresent() ? accountId.get() : "N/A"}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:
                  Text("Destination and Premises Identification number (PID)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(destinationLocationId))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Name")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(destinationLocationName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Address")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$destinationAddress'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Receiver’s Contact number in case of emergency")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(receiverContactInfo))),
    ]);
  }
}
