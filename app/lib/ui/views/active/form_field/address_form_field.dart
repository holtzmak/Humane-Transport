import 'package:app/core/models/address.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

/// A custom form field for Addresses
/// Intended to be used inside a GroupFormField
class AddressFormField extends StatefulWidget {
  final Address initialAddr;
  final Function(Address) onSaved;

  AddressFormField(
      {Key key, @required this.initialAddr, @required this.onSaved})
      : super(key: key);

  @override
  _AddressFormFieldState createState() => _AddressFormFieldState();
}

class _AddressFormFieldState extends State<AddressFormField> {
  // TODO: Make the address from known countries, states, cities
  // https://pub.dev/packages/country_state_city_picker
  String _street;
  String _city;
  String _provinceOrState;
  String _country;
  String _postalCode;

  @override
  void initState() {
    _street = widget.initialAddr.streetAddress;
    _city = widget.initialAddr.city;
    _provinceOrState = widget.initialAddr.provinceOrState;
    _country = widget.initialAddr.country;
    _postalCode = widget.initialAddr.postalCode;
    super.initState();
  }

  void _saveAll() => widget.onSaved(Address(
      streetAddress: _street,
      city: _city,
      provinceOrState: _provinceOrState,
      country: _country,
      postalCode: _postalCode));

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StringFormField(
          initial: _street,
          title: "Street",
          onSaved: (String changed) {
            _street = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _city,
          title: "City",
          onSaved: (String changed) {
            _city = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _provinceOrState,
          title: "Province or State",
          onSaved: (String changed) {
            _provinceOrState = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _country,
          title: "Country",
          onSaved: (String changed) {
            _country = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _postalCode,
          title: "Postal Code",
          onSaved: (String changed) {
            _postalCode = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
    ]);
  }
}
