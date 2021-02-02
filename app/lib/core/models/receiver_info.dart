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
}
