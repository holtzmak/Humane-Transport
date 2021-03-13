import 'package:app/core/models/address.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/address_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

class ShipperInfoFormField extends StatefulWidget {
  final Function(ShipperInfo info) onSaved;
  final ShipperInfo initialInfo;
  final String title = "Shipper's Information";
  final _formKey = GlobalKey<FormState>();

  void save() => _formKey.currentState.save();

  bool validate() => _formKey.currentState.validate();

  ShipperInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _ShipperInfoFormFieldState createState() => _ShipperInfoFormFieldState();
}

class _ShipperInfoFormFieldState extends State<ShipperInfoFormField> {
  String _name;
  String _isAnimalOwner;
  String _departureId;
  String _departureLocationName;
  String _contactInfo;
  Address _departureAddress;

  AddressFormField _departureAddressFormField;

  @override
  void initState() {
    _name = widget.initialInfo.shipperName;
    _isAnimalOwner = widget.initialInfo.shipperIsAnimalOwner ? "Yes" : "No";
    _departureId = widget.initialInfo.departureLocationId;
    _departureLocationName = widget.initialInfo.departureLocationName;
    _contactInfo = widget.initialInfo.shipperContactInfo;
    _departureAddress = widget.initialInfo.departureAddress;
    _departureAddressFormField = AddressFormField(
        initialAddr: widget.initialInfo.departureAddress,
        onSaved: (Address changed) {
          _departureAddress = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(ShipperInfo(
      shipperName: _name,
      shipperIsAnimalOwner: _isAnimalOwner == "Yes" ? true : false,
      departureLocationId: _departureId,
      departureLocationName: _departureLocationName,
      departureAddress: _departureAddress,
      shipperContactInfo: _contactInfo));

  void _validateAndSaveAll() {
    if (widget.validate()) widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(children: [
        StringFormField(
            initial: _name,
            title: "Name",
            onSaved: (String changed) {
              _name = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
            title: DropdownButtonFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText:
                  "The shipper is the owner of the animals loaded in the vehicle?"),
          value: _isAnimalOwner,
          items: ["Yes", "No"]
              .map((label) => DropdownMenuItem(
                    child: Text(label),
                    value: label,
                  ))
              .toList(),
          onChanged: (String changed) => setState(() {
            _isAnimalOwner = changed;
            _saveAll();
          }),
        )),
        StringFormField(
            initial: _departureId,
            title: "Departure Premises Identification number (PID)",
            onSaved: (String changed) {
              _departureId = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _departureLocationName,
            title: "Departure Premises Name",
            onSaved: (String changed) {
              _departureLocationName = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
            title: Text("Departure Premises Address"),
            subtitle: _departureAddressFormField),
        StringFormField(
            initial: _contactInfo,
            title: "Shipper’s Contact information in case of emergency",
            onSaved: (String changed) {
              _contactInfo = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        RaisedButton(child: Text("Save"), onPressed: _validateAndSaveAll)
      ]),
    );
  }
}
