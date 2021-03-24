import 'package:app/ui/common/style.dart';
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

  factory TransporterInfo.defaultTransporterInfo() => TransporterInfo(
      companyName: "",
      companyAddress: Address.defaultAddress(),
      driverNames: [],
      vehicleProvince: "",
      vehicleLicensePlate: "",
      trailerProvince: "",
      trailerLicensePlate: "",
      dateLastCleaned: DateTime.now(),
      addressLastCleanedAt: Address.defaultAddress(),
      driversAreBriefed: false,
      driversHaveTraining: false,
      trainingType: "",
      trainingExpiryDate: DateTime.now());

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
        _driverNames = List.from(json['driverNames']),
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
        'driverNames': _driverNames,
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

  String toString() => '''\nName of transporting company: $companyName
  \nAddress: $companyAddress
  \nDriver(s) name(s): ${driverNames.join(",")}
  \nProvince and License Plate number of the conveyance transporting the animals: $vehicleProvince, $vehicleLicensePlate
  \n(including trailer): $trailerProvince, $trailerProvince
  \nConveyance or container last cleaned and disinfected date and time: ${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}
  \nPlace: $addressLastCleanedAt
  \nDriver(s) have been briefed on the contingency plan?: ${driversAreBriefed ? 'Yes' : 'No'}
  \nDriver(s) have received humane transport training?: ${driversHaveTraining ? 'Yes' : 'No'}
  \nTraining type: $trainingType, Expiry date: ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}''';

  Widget toWidget() {
    return Column(children: [
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Name of transporting company")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(companyName))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Address")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$companyAddress'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Driver(s) name(s)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${_driverNames.join(",")}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                  "Province and License Plate number of the conveyance transporting the animals")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$vehicleProvince, $vehicleLicensePlate'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("(including trailer)")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('$trailerProvince, $trailerLicensePlate'))),
      ListTile(
          title: Text("Conveyance or container last cleaned and disinfected")),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Date and time")),
          subtitle: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
            child: Text(
                '${DateFormat("yyyy-MM-dd hh:mm").format(dateLastCleaned)}'),
          )),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Text("Place")),
          subtitle: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
            child: Text('$addressLastCleanedAt'),
          )),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:
                  Text("Driver(s) have been briefed on the contingency plan?")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${driversAreBriefed ? 'Yes' : 'No'}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:
                  Text("Driver(s) have received humane transport training?")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text('${driversHaveTraining ? 'Yes' : 'No'}'))),
      ListTile(
          title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Training type and Expiry date")),
          subtitle: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: NavyBlue)),
              child: Text(
                  '$trainingType, ${DateFormat("yyyy-MM-dd hh:mm").format(trainingExpiryDate)}'))),
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
      ),
    ]);
  }
}
