import 'package:app/ui/common/style.dart';
import 'package:flutter/material.dart';

@immutable
class AcknowledgementInfo {
  final String shipperAck;
  final String transporterAck;
  final String receiverAck;

  AcknowledgementInfo(
      {@required this.shipperAck,
      @required this.transporterAck,
      @required this.receiverAck});

  factory AcknowledgementInfo.empty() =>
      AcknowledgementInfo(shipperAck: "", transporterAck: "", receiverAck: "");

  @override
  int get hashCode =>
      shipperAck.hashCode ^ transporterAck.hashCode ^ receiverAck.hashCode;

  @override
  bool operator ==(other) {
    return (other is AcknowledgementInfo) &&
        other.shipperAck == shipperAck &&
        other.transporterAck == transporterAck &&
        other.receiverAck == receiverAck;
  }

  AcknowledgementInfo.fromJSON(Map<String, dynamic> json)
      : shipperAck = json['shipperAck'],
        transporterAck = json['transporterAck'],
        receiverAck = json['receiverAck'];

  Map<String, dynamic> toJSON() => {
        'shipperAck': shipperAck,
        'transporterAck': transporterAck,
        'receiverAck': receiverAck
      };

  String toString() =>
      "Shipper acknowledgement: $shipperAck, Transporter acknowledgement: $transporterAck, Consignee acknowledgement: $receiverAck";

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Shipper acknowledgement")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Image.network(shipperAck))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Transporter acknowledgement")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Image.network(transporterAck))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Consignee acknowledgement")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Image.network(receiverAck))),
    ]);
  }
}
