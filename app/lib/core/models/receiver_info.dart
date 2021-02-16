import 'package:app/core/utilities/optional.dart';
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

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Receiving company name"),
          subtitle: Text(receiverCompanyName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Representative name"),
          subtitle: Text(receiverName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Account identification number of the consignee in the database of the responsible administrator (Optional)"),
          subtitle: Text('${accountId.isPresent() ? accountId.get() : "N/A"}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Destination and Premises Identification number (PID)"),
          subtitle: Text(destinationLocationId)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Name"),
          subtitle: Text(destinationLocationName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Address"),
          subtitle: Text('$destinationAddress')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Receiver’s Contact number in case of emergency"),
          subtitle: Text(receiverContactInfo)),
    ]);
  }
}
