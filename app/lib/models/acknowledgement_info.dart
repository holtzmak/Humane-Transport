import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class AcknowledgementInfo {
  final File shipperAck;
  final File transporterAck;
  final File receiverAck;

  AcknowledgementInfo(
      {@required File shipperAck,
      @required File transporterAck,
      @required File receiverAck})
      : shipperAck = shipperAck,
        transporterAck = transporterAck,
        receiverAck = receiverAck;
}
