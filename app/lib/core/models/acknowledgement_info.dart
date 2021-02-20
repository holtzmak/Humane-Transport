import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class AcknowledgementInfo {
  final File shipperAck;
  final File transporterAck;
  final File receiverAck;

  AcknowledgementInfo(
      {@required this.shipperAck,
      @required this.transporterAck,
      @required this.receiverAck});

  AcknowledgementInfo.fromJSON(Map<String, dynamic> json)
      : shipperAck = json['shipperAck'],
        transporterAck = json['transporterAck'],
        receiverAck = json['receiverAck'];

  Map<String, dynamic> toJSON() => {
        'shipperAck': shipperAck,
        'transporterAck': transporterAck,
        'receiverAck': receiverAck
      };

  // TODO: Resolve how to display ack info, if it's an image or w/e
  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Shipper acknowledgement")),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Transporter acknowledgement")),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Consignee acknowledgement")),
    ]);
  }
}
