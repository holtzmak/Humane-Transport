import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'address_form_field.dart';

/// A custom form field with onSaved and onDelete callback
class FeedWaterRestEventFormField extends StatefulWidget {
  final FeedWaterRestEvent initial;
  final Function(FeedWaterRestEvent) onSaved;
  final Function() onDelete;

  FeedWaterRestEventFormField(
      {Key key,
      @required this.initial,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _FeedWaterRestEventFormFieldState createState() =>
      _FeedWaterRestEventFormFieldState();
}

class _FeedWaterRestEventFormFieldState
    extends State<FeedWaterRestEventFormField> {
  String _animalsWereUnloaded;
  DateTime _fwrTime;
  Address _lastFwrLocation;
  String _fwrProvidedOnboard;

  AddressFormField _lastFwrAddressFormField;

  @override
  void initState() {
    _animalsWereUnloaded = widget.initial.animalsWereUnloaded ? "Yes" : "No";
    _fwrTime = widget.initial.fwrTime;
    _lastFwrLocation = widget.initial.lastFwrLocation;
    _fwrProvidedOnboard = widget.initial.fwrProvidedOnboard ? "Yes" : "No";

    _lastFwrAddressFormField = AddressFormField(
        initialAddr: _lastFwrLocation,
        onSaved: (Address changed) {
          _lastFwrLocation = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(FeedWaterRestEvent(
      animalsWereUnloaded: _animalsWereUnloaded == "Yes" ? true : false,
      fwrTime: _fwrTime,
      lastFwrLocation: _lastFwrLocation,
      fwrProvidedOnboard: _fwrProvidedOnboard == "Yes" ? true : false));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("FWR Event"),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Animals unloaded?"),
          subtitle: DropdownButtonFormField(
            value: _animalsWereUnloaded,
            items: ["Yes", "No"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String changed) => setState(() {
              _animalsWereUnloaded = changed;
              _saveAll();
            }),
          ),
        ),
        ListTile(
            title: Text("Date and time"),
            subtitle: dateTimePicker(
                initialDate: _fwrTime,
                onSaved: (String changed) {
                  _fwrTime = DateTime.parse(changed);
                  _saveAll();
                })),
        ListTile(title: Text("Address"), subtitle: _lastFwrAddressFormField),
        ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            title: Text("Feed, water, and rest provided onboard?"),
            subtitle: DropdownButtonFormField(
              value: _fwrProvidedOnboard,
              items: ["Yes", "No"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String changed) => setState(() {
                _fwrProvidedOnboard = changed;
                _saveAll();
              }),
            )),
      ],
    );
  }
}
