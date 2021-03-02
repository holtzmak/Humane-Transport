import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class AcknowledgementInfo {
  // TODO: Resolve how to display ack info, if it's an image or w/e
  // The File type is temporary until we have a ack type
  final File shipperAck;
  final File transporterAck;
  final File receiverAck;

  AcknowledgementInfo(
      {@required this.shipperAck,
      @required this.transporterAck,
      @required this.receiverAck});

  // TODO: Add mock files or something, we're not likely to use this
  factory AcknowledgementInfo.defaultAckInfo(
          {File shipperAck, File transporterAck, File receiverAck}) =>
      AcknowledgementInfo(
          shipperAck: null, transporterAck: null, receiverAck: null);

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
      // : shipperAck = File(json['shipperAck']),
      //   transporterAck = File(json['transporterAck']),
      //   receiverAck = File(json['receiverAck']);
      : shipperAck = null,
        transporterAck = null,
        receiverAck = null;

  Map<String, dynamic> toJSON() => {
        'shipperAck': shipperAck,
        'transporterAck': transporterAck,
        'receiverAck': receiverAck
      };

  // TODO: Resolve how to print ack info
  String toString() =>
      "Shipper acknowledgement: , Transporter acknowledgement: , Consignee acknowledgement: ";

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
