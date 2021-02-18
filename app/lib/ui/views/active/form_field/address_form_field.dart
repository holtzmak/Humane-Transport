import 'package:app/core/models/address.dart';
import 'package:flutter/material.dart';

/// A custom form field for addresses
/// Intended to be used inside a GroupFormField
class AddressFormField extends StatefulWidget {
  // TODO: Make the address from known countries, states, cities
  // https://pub.dev/packages/country_state_city_picker
  final TextEditingController _streetController;
  final TextEditingController _cityController;
  final TextEditingController _stateController;
  final TextEditingController _countryController;
  final TextEditingController _postCodeController;

  AddressFormField({Key key, @required Address initialAddr})
      : _streetController =
            TextEditingController(text: initialAddr.streetAddress),
        _cityController = TextEditingController(text: initialAddr.city),
        _stateController =
            TextEditingController(text: initialAddr.provinceOrState),
        _countryController = TextEditingController(text: initialAddr.country),
        _postCodeController =
            TextEditingController(text: initialAddr.postalCode),
        super(key: key);

  @override
  _AddressFormFieldState createState() => _AddressFormFieldState();

  Address getAddress() => Address(
      streetAddress: _streetController.text,
      city: _cityController.text,
      provinceOrState: _stateController.text,
      country: _countryController.text,
      postalCode: _postCodeController.text);
}

class _AddressFormFieldState extends State<AddressFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text("Street"),
          subtitle: TextFormField(
            controller: widget._streetController,
          )),
      ListTile(
          title: Text("City"),
          subtitle: TextFormField(
            controller: widget._cityController,
          )),
      ListTile(
          title: Text("Province or State"),
          subtitle: TextFormField(
            controller: widget._stateController,
          )),
      ListTile(
          title: Text("Country"),
          subtitle: TextFormField(
            controller: widget._countryController,
          )),
      ListTile(
          title: Text("Postal Code"),
          subtitle: TextFormField(
            controller: widget._postCodeController,
          )),
    ]);
  }
}
