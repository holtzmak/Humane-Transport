import 'package:app/common/utilities/address.dart';
import 'package:app/common/utilities/optional.dart';
import 'package:flutter/material.dart';

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
      this.receiverCompanyName,
      this.receiverName,
      this.accountId,
      this.destinationLocationId,
      this.destinationLocationName,
      this.destinationAddress,
      this.receiverContactInfo);
}
