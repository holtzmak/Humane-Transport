import 'package:app/core/models/address.dart';
import 'package:flutter/material.dart';

/// A custom form field for addresses
/// Intended to be used inside a GroupFormField
class AddressFormField extends StatefulWidget {
  final Address initialAddr;
  final _AddressFormFieldState state = _AddressFormFieldState();

  AddressFormField({Key key, @required this.initialAddr}) : super(key: key);

  @override
  _AddressFormFieldState createState() => state;

  Address getAddress() => state.getAddress();
}

class _AddressFormFieldState extends State<AddressFormField> {
  // TODO: Make the address from known countries, states, cities
  // https://pub.dev/packages/country_state_city_picker
  TextEditingController _streetController;
  TextEditingController _cityController;
  TextEditingController _stateController;
  TextEditingController _countryController;
  TextEditingController _postCodeController;

  Address getAddress() => Address(
      streetAddress: _streetController.text,
      city: _cityController.text,
      provinceOrState: _stateController.text,
      country: _countryController.text,
      postalCode: _postCodeController.text);

  @override
  void initState() {
    _streetController =
        TextEditingController(text: widget.initialAddr.streetAddress);
    _cityController = TextEditingController(text: widget.initialAddr.city);
    _stateController =
        TextEditingController(text: widget.initialAddr.provinceOrState);
    _countryController =
        TextEditingController(text: widget.initialAddr.country);
    _postCodeController =
        TextEditingController(text: widget.initialAddr.postalCode);
    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text("Street"),
          subtitle: TextFormField(
            controller: _streetController,
          )),
      ListTile(
          title: Text("City"),
          subtitle: TextFormField(
            controller: _cityController,
          )),
      ListTile(
          title: Text("Province or State"),
          subtitle: TextFormField(
            controller: _stateController,
          )),
      ListTile(
          title: Text("Country"),
          subtitle: TextFormField(
            controller: _countryController,
          )),
      ListTile(
          title: Text("Postal Code"),
          subtitle: TextFormField(
            controller: _postCodeController,
          )),
    ]);
  }
}
