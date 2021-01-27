import 'package:app/common/utilities/address.dart';
import 'package:flutter/material.dart';

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
      this.companyName,
      this.companyAddress,
      this._driverNames,
      this.vehicleProvince,
      this.vehicleLicensePlate,
      this.trailerProvince,
      this.trailerLicensePlate,
      this.dateLastCleaned,
      this.addressLastCleanedAt,
      this.driversAreBriefed,
      this.driversHaveTraining,
      this.trainingType,
      this.trainingExpiryDate);

  List<String> driverNames() => List.unmodifiable(_driverNames);
}
