import 'package:app/core/models/address.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

import 'address_form_field.dart';

class TransporterInfoFormField extends StatefulWidget {
  final Function(TransporterInfo info) onSaved;
  final TransporterInfo initialInfo;
  final String title = "Transporter's Information";

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  TransporterInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _TransporterInfoFormFieldState createState() =>
      _TransporterInfoFormFieldState();
}

class _TransporterInfoFormFieldState extends State<TransporterInfoFormField> {
  String _companyName;
  Address _companyAddress;
  List<String> _driverNames;
  String _vehicleProvince;
  String _vehicleLicensePlate;
  String _trailerProvince;
  String _trailerLicensePlate;
  DateTime _dateLastCleaned;
  Address _addressLastCleanedAt;
  String _driversAreBriefed;
  String _driversHaveTraining;
  String _trainingType;
  DateTime _trainingExpiryDate;

  AddressFormField _companyAddressFormField;
  AddressFormField _addressLastCleanedAtFormField;
  DynamicStringFormField _driverNamesFormField;

  @override
  void initState() {
    _companyName = widget.initialInfo.companyName;
    _companyAddress = widget.initialInfo.companyAddress;
    _driverNames = widget.initialInfo.driverNames;
    _vehicleProvince = widget.initialInfo.vehicleProvince;
    _vehicleLicensePlate = widget.initialInfo.vehicleLicensePlate;
    _trailerProvince = widget.initialInfo.trailerProvince;
    _trailerLicensePlate = widget.initialInfo.trailerLicensePlate;
    _dateLastCleaned = widget.initialInfo.dateLastCleaned;
    _addressLastCleanedAt = widget.initialInfo.addressLastCleanedAt;
    _driversAreBriefed = widget.initialInfo.driversAreBriefed ? "Yes" : "No";
    _driversHaveTraining =
        widget.initialInfo.driversHaveTraining ? "Yes" : "No";
    _trainingType = widget.initialInfo.trainingType;
    _trainingExpiryDate = widget.initialInfo.trainingExpiryDate;

    _companyAddressFormField = AddressFormField(
        initialAddr: _companyAddress,
        onSaved: (Address changed) {
          _companyAddress = changed;
          _saveAll();
        });
    _addressLastCleanedAtFormField = AddressFormField(
        initialAddr: _addressLastCleanedAt,
        onSaved: (Address changed) {
          _addressLastCleanedAt = changed;
          _saveAll();
        });
    _driverNamesFormField = DynamicStringFormField(
        initialList: _driverNames,
        titles: "Driver Name",
        onSaved: (List<String> changed) {
          _driverNames = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(TransporterInfo(
      companyName: _companyName,
      companyAddress: _companyAddress,
      driverNames: _driverNames,
      vehicleProvince: _vehicleProvince,
      vehicleLicensePlate: _vehicleLicensePlate,
      trailerProvince: _trailerProvince,
      trailerLicensePlate: _trailerLicensePlate,
      dateLastCleaned: _dateLastCleaned,
      addressLastCleanedAt: _addressLastCleanedAt,
      driversAreBriefed: _driversAreBriefed == "Yes" ? true : false,
      driversHaveTraining: _driversHaveTraining == "Yes" ? true : false,
      trainingType: _trainingType,
      trainingExpiryDate: _trainingExpiryDate));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        StringFormField(
            initial: _companyName,
            title: "Name of transporting company",
            onSaved: (String changed) {
              _companyName = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
            title: Text("Transporting Company Address"),
            subtitle: _companyAddressFormField),
        ListTile(title: Text("Driver(s) name(s)")),
        _driverNamesFormField,
        StringFormField(
            initial: _vehicleProvince,
            title: "Province of the conveyance transporting the animals",
            onSaved: (String changed) {
              _vehicleProvince = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _vehicleLicensePlate,
            title: "License plate of the conveyance transporting the animals",
            onSaved: (String changed) {
              _vehicleLicensePlate = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _trailerProvince,
            title: "Province of the trailer",
            onSaved: (String changed) {
              _trailerProvince = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _trailerLicensePlate,
            title: "License plate of the trailer",
            onSaved: (String changed) {
              _trailerLicensePlate = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
            title: Text(
                "Date and time conveyance or container last cleaned and disinfected"),
            subtitle: Text("TODO: Date picker")),
        ListTile(
            title: Text(
                "Address conveyance or container last cleaned and disinfected at"),
            subtitle: _addressLastCleanedAtFormField),
        ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            title: Text("Driver(s) have been briefed on the contingency plan?"),
            subtitle: DropdownButtonFormField(
              value: _driversAreBriefed,
              items: ["Yes", "No"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String changed) => setState(() {
                _driversAreBriefed = changed;
                _saveAll();
              }),
            )),
        ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            title: Text("Driver(s) have received humane transport training?"),
            subtitle: DropdownButtonFormField(
              value: _driversHaveTraining,
              items: ["Yes", "No"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String changed) => setState(() {
                _driversHaveTraining = changed;
                _saveAll();
              }),
            )),
        StringFormField(
            initial: _trainingType,
            title: "Training type",
            onSaved: (String changed) {
              _trainingType = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
            title: Text("Training expiry date"),
            subtitle: Text("TODO: Date picker")),
        RaisedButton(child: Text("Save"), onPressed: _saveAll)
      ]),
    );
  }
}
