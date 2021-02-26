import 'package:flutter/foundation.dart';
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

  List<String> get driverNames => List.unmodifiable(_driverNames);

  @override
  int get hashCode =>
      companyName.hashCode ^
      companyAddress.hashCode ^
      _driverNames.hashCode ^
      vehicleProvince.hashCode ^
      vehicleLicensePlate.hashCode ^
      trailerProvince.hashCode ^
      trailerLicensePlate.hashCode ^
      dateLastCleaned.hashCode ^
      addressLastCleanedAt.hashCode ^
      driversAreBriefed.hashCode ^
      driversHaveTraining.hashCode ^
      trainingType.hashCode ^
      trainingExpiryDate.hashCode;

  @override
  bool operator ==(other) {
    return (other is TransporterInfo) &&
        other.companyName == companyName &&
        other.companyAddress == companyAddress &&
        listEquals(other.driverNames, _driverNames) &&
        other.vehicleProvince == vehicleProvince &&
        other.vehicleLicensePlate == vehicleLicensePlate &&
        other.trailerProvince == trailerProvince &&
        other.trailerLicensePlate == trailerLicensePlate &&
        other.dateLastCleaned == dateLastCleaned &&
        other.addressLastCleanedAt == addressLastCleanedAt &&
        other.driversAreBriefed == driversAreBriefed &&
        other.driversHaveTraining == driversHaveTraining &&
        other.trainingType == trainingType &&
        other.trainingExpiryDate == trainingExpiryDate;
  }

  TransporterInfo.fromJSON(Map<String, dynamic> json)
      : companyName = json['companyName'],
        companyAddress = Address.fromJSON(json['companyAddress']),
        _driverNames = List.from(json['_driverNames']),
        vehicleProvince = json['vehicleProvince'],
        vehicleLicensePlate = json['vehicleLicensePlate'],
        trailerProvince = json['trailerProvince'],
        trailerLicensePlate = json['trailerLicensePlate'],
        dateLastCleaned = json['dateLastCleaned'].toDate(),
        addressLastCleanedAt = Address.fromJSON(json['addressLastCleanedAt']),
        driversAreBriefed = json['driversAreBriefed'],
        driversHaveTraining = json['driversHaveTraining'],
        trainingType = json['trainingType'],
        trainingExpiryDate = json['trainingExpiryDate'].toDate();

  Map<String, dynamic> toJSON() => {
        'companyName': companyName,
        'companyAddress': companyAddress.toJSON(),
        '_driverNames': _driverNames,
        'vehicleProvince': vehicleProvince,
        'vehicleLicensePlate': vehicleLicensePlate,
        'trailerProvince': trailerProvince,
        'trailerLicensePlate': trailerLicensePlate,
        'dateLastCleaned': dateLastCleaned,
        'addressLastCleanedAt': addressLastCleanedAt.toJSON(),
        'driversAreBriefed': driversAreBriefed,
        'driversHaveTraining': driversHaveTraining,
        'trainingType': trainingType,
        'trainingExpiryDate': trainingExpiryDate,
      };

  String toString() => '''Name of transporting company: $companyName
  Address: $companyAddress
  Driver(s) name(s): ${driverNames.join(",")}
  Province and License Plate number of the conveyance transporting the animals: $vehicleProvince, $vehicleLicensePlate
  (including trailer): $trailerProvince, $trailerProvince
  Conveyance or container last cleaned and disinfected date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}
  Place: $addressLastCleanedAt
  Driver(s) have been briefed on the contingency plan?: ${driversAreBriefed ? 'Yes' : 'No'}
  Driver(s) have received humane transport training?: ${driversHaveTraining ? 'Yes' : 'No'}
  Training type: $trainingType, Expiry date: ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Name of transporting company"),
          subtitle: Text(companyName)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Address"),
          subtitle: Text('$companyAddress')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) name(s)"),
          subtitle: Text('${_driverNames.join(",")}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Province and License Plate number of the conveyance transporting the animals"),
          subtitle: Text('$vehicleProvince, $vehicleLicensePlate')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("(including trailer)"),
          subtitle: Text('$trailerProvince, $trailerLicensePlate')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Conveyance or container last cleaned and disinfected")),
      ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        title: Text("Date and time"),
        subtitle:
            Text('${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}'),
      ),
      ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        title: Text("Place"),
        subtitle: Text('$addressLastCleanedAt'),
      ),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) have been briefed on the contingency plan?"),
          subtitle: Text('${driversAreBriefed ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Driver(s) have received humane transport training?"),
          subtitle: Text('${driversHaveTraining ? 'Yes' : 'No'}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Training type and Expiry date"),
          subtitle: Text(
              '$trainingType, ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}')),
    ]);
  }
}
