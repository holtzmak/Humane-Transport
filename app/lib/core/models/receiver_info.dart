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

  String toString() => '''Receiving company name: $receiverCompanyName
  Representative name: $receiverName
  Account identification number of the consignee in the database of the responsible administrator (Optional): ${accountId.isPresent() ? accountId.get() : "N/A"}
  Destination and Premises Identification number (PID): $destinationLocationId, Name: $destinationLocationName
  Address: $destinationAddress
  Receiver’s Contact number in case of emergency: $receiverContactInfo''';
}
