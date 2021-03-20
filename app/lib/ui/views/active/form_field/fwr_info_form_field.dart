import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_fwr_event_form_field.dart';
import 'package:app/ui/views/active/form_field/address_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

class FeedWaterRestInfoFormField extends StatefulWidget {
  final Function(FeedWaterRestInfo info) onSaved;
  final FeedWaterRestInfo initialInfo;
  final String title = "Feed, Water, and Rest Information";
  final _innerFormKey = GlobalKey<FormState>();

  void save() => _innerFormKey.currentState.save();

  // This function does not change the state of the widget
  // Must call validate within widget for error text to appear
  bool validate() => _innerFormKey.currentState.validate();

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
  DynamicFormField<FeedWaterRestEvent> _fwrEventFormField;

  @override
  void initState() {
    _lastFwrDate = widget.initialInfo.lastFwrDate;
    _lastFwrLocation = widget.initialInfo.lastFwrLocation;
    _fwrEvents = widget.initialInfo.fwrEvents;
    _lastFwrAddressFormField = AddressFormField(
        initialAddr: _lastFwrLocation,
        onSaved: (Address changed) {
          _lastFwrLocation = changed;
          _saveNestedForms();
          _saveAll();
        });
    _fwrEventFormField = dynamicFWREventFormField(
        initialList: _fwrEvents,
        onSaved: (List<FeedWaterRestEvent> changed) {
          _fwrEvents = changed;
          _saveAll();
        });
    super.initState();
  }

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() => _fwrEventFormField.save();

  void _saveAll() => widget.onSaved(FeedWaterRestInfo(
      lastFwrDate: _lastFwrDate,
      lastFwrLocation: _lastFwrLocation,
      fwrEvents: _fwrEvents));

  void _validateAndSaveAll() {
    // Do not short-circuit the validation calls using &&
    final isFormValid = widget._innerFormKey.currentState.validate();
    final isInnerFormValid = _fwrEventFormField.validate();
    if (isFormValid && isInnerFormValid) widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._innerFormKey,
      child: Column(children: [
        ListTile(
            title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    "Last access to feed, water and rest (FWR) prior to loading")),
            subtitle: dateTimePicker(
                initialDate: _lastFwrDate,
                onSaved: (String changed) {
                  _lastFwrDate = DateTime.parse(changed);
                  _saveAll();
                })),
        ListTile(
            title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Last FWR location")),
            subtitle: _lastFwrAddressFormField),
        ListTile(title: Text("If FWR was provided during transport")),
        _fwrEventFormField,
        RaisedButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _validateAndSaveAll)
      ]),
    );
  }
}
