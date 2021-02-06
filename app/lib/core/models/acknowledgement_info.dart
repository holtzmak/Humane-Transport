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

  // TODO: Resolve how to display ack info
  // Most other info is strings, perhaps this should give a widget for display
  String toString() => '''Shipper acknowledgement:
  Transporter acknowledgement:
  Consignee acknowledgement:
  ''';
}
