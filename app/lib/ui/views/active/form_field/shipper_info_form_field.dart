import 'package:app/core/models/shipper_info.dart';
import 'package:flutter/material.dart';

import 'address_form_field.dart';
import 'group_form_field.dart';

class ShipperInfoFormField extends GroupFormField<ShipperInfo> {
  final _ShipperInfoFormFieldState _state = _ShipperInfoFormFieldState();
  final Function(ShipperInfo info) onSaved;
  final ShipperInfo initialInfo;

  ShipperInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key, formName: "Shipper's Information");

  @override
  _ShipperInfoFormFieldState createState() => _state;

  @override
  void save() => _state.save();
}

class _ShipperInfoFormFieldState extends State<ShipperInfoFormField> {
  TextEditingController _nameController;
  TextEditingController _isAnimalOwnerController;
  TextEditingController _departureIdController;
  TextEditingController _departureNameController;
  AddressFormField _addressFormField;
  TextEditingController _contactInfoController;

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.initialInfo.shipperName);
    _isAnimalOwnerController = TextEditingController(
        text: widget.initialInfo.shipperIsAnimalOwner ? "Yes" : "No");
    _departureIdController =
        TextEditingController(text: widget.initialInfo.departureLocationId);
    _departureNameController =
        TextEditingController(text: widget.initialInfo.departureLocationName);
    _addressFormField =
        AddressFormField(initialAddr: widget.initialInfo.departureAddress);
    _contactInfoController =
        TextEditingController(text: widget.initialInfo.shipperContactInfo);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _isAnimalOwnerController.dispose();
    _departureIdController.dispose();
    _departureNameController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  void save() {
    widget.onSaved(ShipperInfo(
        shipperName: _nameController.text,
        shipperIsAnimalOwner:
            _isAnimalOwnerController.text == "Yes" ? true : false,
        departureLocationId: _departureIdController.text,
        departureLocationName: _departureNameController.text,
        departureAddress: _addressFormField.getAddress(),
        shipperContactInfo: _contactInfoController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: _nameController,
          )),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "The shipper is the owner of the animals loaded in the vehicle?"),
          subtitle: DropdownButtonFormField(
            value: _isAnimalOwnerController.text,
            items: ["Yes", "No"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String value) => setState(() {
              _isAnimalOwnerController.text = value;
            }),
          )),
      ListTile(
          title: Text("Departure Premises Identification number (PID)"),
          subtitle: TextFormField(
            controller: _departureIdController,
          )),
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: _departureNameController,
          )),
      ListTile(title: Text("Address"), subtitle: _addressFormField),
      ListTile(
          title: Text("Shipper’s Contact information in case of emergency"),
          subtitle: TextFormField(
            controller: _contactInfoController,
          )),
      RaisedButton(child: Text("Save"), onPressed: widget.save)
    ]);
  }
}
