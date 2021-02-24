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

  TransporterInfo.fromJSON(Map<String, dynamic> json)
      : companyName = json['companyName'],
        companyAddress = Address.fromJSON(json['companyAddress']),
        _driverNames = List.from(json['_driverNames']),
        vehicleProvince = json['vehicleProvince'],
        vehicleLicensePlate = json['vehicleLicensePlate'],
        trailerProvince = json['trailerProvince'],
        trailerLicensePlate = json['trailerLicensePlate'],
        dateLastCleaned = DateTime.parse(json['dateLastCleaned'].toString()),
        addressLastCleanedAt = Address.fromJSON(json['addressLastCleanedAt']),
        driversAreBriefed = json['driversAreBriefed'],
        driversHaveTraining = json['driversHaveTraining'],
        trainingType = json['trainingType'],
        trainingExpiryDate =
            DateTime.parse(json['trainingExpiryDate'].toString());

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
