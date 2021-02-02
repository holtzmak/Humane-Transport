import 'package:flutter/material.dart';

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
}
