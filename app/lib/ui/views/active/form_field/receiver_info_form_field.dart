import 'package:app/core/models/address.dart';
import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/address_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

class ReceiverInfoFormField extends StatefulWidget {
  final Function(ReceiverInfo info) onSaved;
  final ReceiverInfo initialInfo;

  ReceiverInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _ReceiverInfoFormFieldState createState() => _ReceiverInfoFormFieldState();
}

class _ReceiverInfoFormFieldState extends State<ReceiverInfoFormField> {
  String _receiverCompanyName;
  String _receiverName;
  Optional<String> _accountId;
  String _destinationLocationId;
  String _destinationLocationName;
  Address _destinationAddress;
  String _receiverContactInfo;

  AddressFormField _destinationAddressFormField;

  @override
  void initState() {
    _receiverCompanyName = widget.initialInfo.receiverCompanyName;
    _receiverName = widget.initialInfo.receiverName;
    _accountId = widget.initialInfo.accountId;
    _destinationLocationId = widget.initialInfo.destinationLocationId;
    _destinationLocationName = widget.initialInfo.destinationLocationName;
    _destinationAddress = widget.initialInfo.destinationAddress;
    _receiverContactInfo = widget.initialInfo.receiverContactInfo;
    _destinationAddressFormField = AddressFormField(
        initialAddr: _destinationAddress,
        onSaved: (Address changed) {
          _destinationAddress = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(ReceiverInfo(
      receiverCompanyName: _receiverCompanyName,
      receiverName: _receiverName,
      accountId: _accountId,
      destinationLocationId: _destinationLocationId,
      destinationLocationName: _destinationLocationName,
      destinationAddress: _destinationAddress,
      receiverContactInfo: _receiverContactInfo));

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StringFormField(
          initial: _receiverCompanyName,
          title: "Receiving company name",
          onSaved: (String changed) {
            _receiverCompanyName = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _receiverName,
          title: "Representative name",
          onSaved: (String changed) {
            _receiverName = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _accountId.isPresent() ? _accountId.get() : "",
          title:
              "Account identification number of the consignee in the database of the responsible administrator (Optional)",
          onSaved: (String changed) {
            _accountId =
                changed == "" ? Optional.empty() : Optional.of(changed);
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _destinationLocationId,
          title: "Destination and Premises Identification number (PID)",
          onSaved: (String changed) {
            _destinationLocationId = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      StringFormField(
          initial: _destinationLocationName,
          title: "Destination and Premises name",
          onSaved: (String changed) {
            _destinationLocationName = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      ListTile(
        title: Text("Destination and Premises address"),
        subtitle: _destinationAddressFormField,
      ),
      StringFormField(
          initial: _receiverContactInfo,
          title: "Receiver’s Contact number in case of emergency",
          onSaved: (String changed) {
            _receiverContactInfo = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
    ]);
  }
}
