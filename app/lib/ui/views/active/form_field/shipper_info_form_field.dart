import 'package:app/core/models/address.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:flutter/material.dart';

import 'group_form_field.dart';

class ShipperInfoFormField extends GroupFormField<ShipperInfo> {
  final Function(ShipperInfo info) onSaved;
  final TextEditingController _nameController;
  final TextEditingController _isAnimalOwnerController;
  final TextEditingController _departureIdController;
  final TextEditingController _departureNameController;
  final TextEditingController _contactInfoController;

  ShipperInfoFormField(
      {Key key, @required ShipperInfo initialInfo, @required this.onSaved})
      : _nameController = TextEditingController(text: initialInfo.shipperName),
        _isAnimalOwnerController = TextEditingController(
            text: initialInfo.shipperIsAnimalOwner ? "Yes" : "No"),
        _departureIdController =
            TextEditingController(text: initialInfo.departureLocationId),
        _departureNameController =
            TextEditingController(text: initialInfo.departureLocationName),
        _contactInfoController =
            TextEditingController(text: initialInfo.shipperContactInfo),
        super(key: key);

  @override
  _ShipperInfoFormFieldState createState() => _ShipperInfoFormFieldState();

  @override
  void save() {
    onSaved(ShipperInfo(
        shipperName: _nameController.text,
        shipperIsAnimalOwner: _isAnimalOwnerController == "Yes" ? true : false,
        departureLocationId: _departureIdController.text,
        departureLocationName: _departureNameController.text,
        departureAddress: Address(
            streetAddress: "123 Anywhere St.",
            city: "Somewhere",
            provinceOrState: "Someplace",
            country: "Somehow",
            postalCode: "ABC123"),
        shipperContactInfo: _contactInfoController.text));
  }
}

class _ShipperInfoFormFieldState extends State<ShipperInfoFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: widget._nameController,
          )),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "The shipper is the owner of the animals loaded in the vehicle?"),
          subtitle: DropdownButtonFormField(
            value: widget._isAnimalOwnerController.text,
            items: ["Yes", "No"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String value) => setState(() {
              widget._isAnimalOwnerController.text = value;
            }),
          )),
      ListTile(
          title: Text("Departure Premises Identification number (PID)"),
          subtitle: TextFormField(
            controller: widget._departureIdController,
          )),
      ListTile(
          title: Text("Name"),
          subtitle: TextFormField(
            controller: widget._departureNameController,
          )),
      // Make AddressFormField
      // ListTile(
      //     title: Text("Address"),
      //     subtitle: TextFormField(
      //       controller: _departureNameController,
      //       initialValue: widget.initialInfo.departureLocationName,
      //     )),
      ListTile(
          title: Text("Shipper’s Contact information in case of emergency"),
          subtitle: TextFormField(
            controller: widget._contactInfoController,
          )),
      RaisedButton(child: Text("Save"), onPressed: widget.save)
    ]);
  }
}
