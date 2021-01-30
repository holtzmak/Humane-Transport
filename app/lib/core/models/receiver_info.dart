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
      {@required String receiverCompanyName,
      @required String receiverName,
      @required Optional<String> accountId,
      @required String destinationLocationId,
      @required String destinationLocationName,
      @required Address destinationAddress,
      @required String receiverContactInfo})
      : receiverCompanyName = receiverCompanyName,
        receiverName = receiverName,
        accountId = accountId,
        destinationLocationId = destinationLocationId,
        destinationLocationName = destinationLocationName,
        destinationAddress = destinationAddress,
        receiverContactInfo = receiverContactInfo;
}
