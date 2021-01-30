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
      {@required String companyName,
      @required Address companyAddress,
      @required List<String> driverNames,
      @required String vehicleProvince,
      @required String vehicleLicensePlate,
      @required String trailerProvince,
      @required String trailerLicensePlate,
      @required DateTime dateLastCleaned,
      @required Address addressLastCleanedAt,
      @required bool driversAreBriefed,
      @required bool driversHaveTraining,
      @required String trainingType,
      @required DateTime trainingExpiryDate})
      : companyName = companyName,
        companyAddress = companyAddress,
        _driverNames = driverNames,
        vehicleProvince = vehicleProvince,
        vehicleLicensePlate = vehicleLicensePlate,
        trailerProvince = trailerProvince,
        trailerLicensePlate = trailerLicensePlate,
        dateLastCleaned = dateLastCleaned,
        addressLastCleanedAt = addressLastCleanedAt,
        driversAreBriefed = driversAreBriefed,
        driversHaveTraining = driversHaveTraining,
        trainingType = trainingType,
        trainingExpiryDate = trainingExpiryDate;

  List<String> driverNames() => List.unmodifiable(_driverNames);
}
