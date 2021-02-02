import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'address.dart';

@immutable
class TransporterInfo {
  final String companyName;
  final Address companyAddress;
  final List<String> _driverNames;
  final String vehicleProvince;
  final String vehicleLicensePlate;
  final String trailerProvince;
  final String trailerLicensePlate;
  final DateTime dateLastCleaned;
  final Address addressLastCleanedAt;
  final bool driversAreBriefed;
  final bool driversHaveTraining;
  final String trainingType;
  final DateTime trainingExpiryDate;

  TransporterInfo(
      {@required this.companyName,
      @required this.companyAddress,
      @required List<String> driverNames,
      @required this.vehicleProvince,
      @required this.vehicleLicensePlate,
      @required this.trailerProvince,
      @required this.trailerLicensePlate,
      @required this.dateLastCleaned,
      @required this.addressLastCleanedAt,
      @required this.driversAreBriefed,
      @required this.driversHaveTraining,
      @required this.trainingType,
      @required this.trainingExpiryDate})
      : _driverNames = driverNames;

  List<String> driverNames() => List.unmodifiable(_driverNames);


  String toString() => '''Name and address of transporting company: $companyName
  $companyAddress
  Driver(s) name(s): ${driverNames().join(",")}
  Province and License Plate number of the conveyance transporting the animals: $vehicleProvince, $vehicleLicensePlate
  (including trailer): $trailerProvince, $trailerProvince
  Conveyance or container last cleaned and disinfected:
  Date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}
  Place: $addressLastCleanedAt
  Driver(s) have been briefed on the contingency plan?: ${driversAreBriefed ? 'Yes' : 'No'}
  Driver(s) have received humane transport training?: ${driversHaveTraining ? 'Yes' : 'No'}
  Training type: $trainingType, Expiry date: ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}''';


  Map<String, dynamic> toMap() {

    var map = <String, dynamic>{
      'companyName': companyName,
      'companyAddress': companyAddress,
      'driverNames': _driverNames,
      'vehicleProvinc': vehicleProvince,
      'vehicleLicensePlate': vehicleLicensePlate,
      'trailerProvince': trailerProvince,
      'trailerLicensePlate': trailerLicensePlate,
      'dateLastCleaned': dateLastCleaned,
      'addressLastCleaned': addressLastCleanedAt,
      'driversAreBriefed': driversAreBriefed,
      'driversHaveTraining': driversHaveTraining,
      'trainingType': trainingType,
      'trainingExpiry': trainingExpiryDate,
    };
    return map;
  }

}
