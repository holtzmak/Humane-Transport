import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class AcknowledgementInfo {
  final File shipperAck;
  final File transporterAck;
  final File receiverAck;

  AcknowledgementInfo(this.shipperAck, this.transporterAck, this.receiverAck);
}
