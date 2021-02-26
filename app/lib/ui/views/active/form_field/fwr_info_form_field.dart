import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/ui/views/active/form_field/dynamic_fwr_events_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'address_form_field.dart';

class FeedWaterRestInfoFormField extends StatefulWidget {
  final Function(FeedWaterRestInfo info) onSaved;
  final FeedWaterRestInfo initialInfo;
  final String title = "Feed, Water, and Rest Information";

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  FeedWaterRestInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _FeedWaterRestInfoFormFieldState createState() =>
      _FeedWaterRestInfoFormFieldState();
}

class _FeedWaterRestInfoFormFieldState
    extends State<FeedWaterRestInfoFormField> {
  DateTime _lastFwrDate;
  Address _lastFwrLocation;
  List<FeedWaterRestEvent> _fwrEvents;

  AddressFormField _lastFwrAddressFormField;
  DynamicFWREventFormField _fwrEventFormField;

  @override
  void initState() {
    _lastFwrDate = widget.initialInfo.lastFwrDate;
    _lastFwrLocation = widget.initialInfo.lastFwrLocation;
    _fwrEvents = widget.initialInfo.fwrEvents;
    _lastFwrAddressFormField = AddressFormField(
        initialAddr: _lastFwrLocation,
        onSaved: (Address changed) {
          _lastFwrLocation = changed;
          _saveAll();
        });
    _fwrEventFormField = DynamicFWREventFormField(
        initialList: _fwrEvents,
        onSaved: (List<FeedWaterRestEvent> changed) {
          _fwrEvents = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(FeedWaterRestInfo(
      lastFwrDate: _lastFwrDate,
      lastFwrLocation: _lastFwrLocation,
      fwrEvents: _fwrEvents));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        ListTile(
            title: Text(
                "Last access to feed, water and rest (FWR) prior to loading"),
            subtitle: dateTimePicker(
                initialDate: _lastFwrDate,
                onSaved: (String changed) {
                  _lastFwrDate = DateTime.parse(changed);
                  _saveAll();
                })),
        ListTile(
            title: Text("Last FWR location"),
            subtitle: _lastFwrAddressFormField),
        ListTile(title: Text("If FWR was provided during transport")),
        _fwrEventFormField,
        RaisedButton(child: Text("Save"), onPressed: _saveAll)
      ]),
    );
  }
}
