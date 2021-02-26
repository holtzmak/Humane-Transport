import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/ui/views/active/form_field/fwr_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for FeedWaterRestEvents.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
class DynamicFWREventFormField extends StatefulWidget {
  final List<FeedWaterRestEvent> initialList;
  final String titles = "Feed, Water, and Rest event";
  final Function(List<FeedWaterRestEvent>) onSaved;

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  DynamicFWREventFormField(
      {Key key, @required this.initialList, @required this.onSaved})
      : super(key: key);

  @override
  _DynamicFWREventFormFieldState createState() =>
      _DynamicFWREventFormFieldState();
}

class _DynamicFWREventFormFieldState extends State<DynamicFWREventFormField> {
  final List<FeedWaterRestEvent> _events = [];

  void _saveAll() {
    if (widget.formKey.currentState.validate()) {
      // Calls _saveIndividual for all inner form fields
      widget.formKey.currentState.save();
    }
  }

  void _saveIndividual(int index, FeedWaterRestEvent event) {
    _events[index] = event;
    // TODO: Trim empty strings from the saved list
    // but keep them in the widget's list to have open spots for new items
    widget.onSaved(_events);
  }

  void _deleteField(int index) => setState(() {
        _saveAll();
        _events.removeAt(index);
      });

  void _addField() => setState(() {
        _saveAll();
        _events.add(FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.now(),
            lastFwrLocation: Address(
                streetAddress: "",
                city: "",
                provinceOrState: "",
                country: "",
                postalCode: ""),
            fwrProvidedOnboard: false));
      });

  FeedWaterRestEventFormField _createEvent(int index) {
    return FeedWaterRestEventFormField(
        // Must have unique keys in rebuilding widget lists
        key: ObjectKey(Uuid().v4()),
        initial: _events[index],
        onSaved: (FeedWaterRestEvent changed) =>
            _saveIndividual(index, changed),
        onDelete: () => _deleteField(index));
  }

  @override
  void initState() {
    _events.addAll(widget.initialList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            _events.isEmpty
                ? Text("No events, try adding some!")
                : Container(
                    child: ListView.builder(
                        // Make the List take minimum possible space
                        shrinkWrap: true,
                        // Intended to be used inside existing scroll-ables
                        primary: false,
                        itemCount: _events.length,
                        itemBuilder: (_, index) => _createEvent(index))),
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: _addField,
              ),
            ),
          ],
        ));
  }
}
