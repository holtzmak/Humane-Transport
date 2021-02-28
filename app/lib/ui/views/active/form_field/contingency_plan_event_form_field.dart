import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_contingency_activity_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/contingency_activity_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class ContingencyPlanEventFormField extends StatefulWidget {
  final ContingencyPlanEvent initial;
  final Function(ContingencyPlanEvent) onSaved;
  final Function() onDelete;

  ContingencyPlanEventFormField(
      {Key key,
      @required this.initial,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _ContingencyPlanEventFormFieldState createState() =>
      _ContingencyPlanEventFormFieldState();
}

class _ContingencyPlanEventFormFieldState
    extends State<ContingencyPlanEventFormField> {
  DateTime _eventDateAndTime;
  List<String> _producerContactsUsed;
  List<String> _receiverContactsUsed;
  String _disturbancesIdentified;
  List<ContingencyActivity> _activities;
  List<String> _actionsTaken;

  DynamicFormField<String, StringFormField> _producerContactsUsedFormField;
  DynamicFormField<String, StringFormField> _receiverContactsUsedFormField;
  DynamicFormField<String, StringFormField> _actionsTakenFormField;
  DynamicFormField<ContingencyActivity, ContingencyActivityFormField>
      _contingencyActivitiesFormField;

  @override
  void initState() {
    _eventDateAndTime = widget.initial.eventDateAndTime;
    _producerContactsUsed = widget.initial.producerContactsUsed;
    _receiverContactsUsed = widget.initial.receiverContactsUsed;
    _disturbancesIdentified = widget.initial.disturbancesIdentified;
    _activities = widget.initial.activities;
    _actionsTaken = widget.initial.actionsTaken;

    _producerContactsUsedFormField = dynamicStringFormField(
        initialList: _producerContactsUsed,
        onSaved: (List<String> changed) {
          _producerContactsUsed = changed;
          _saveAll();
        },
        titles: "Producer contact used");
    _receiverContactsUsedFormField = dynamicStringFormField(
        initialList: _receiverContactsUsed,
        onSaved: (List<String> changed) {
          _receiverContactsUsed = changed;
          _saveAll();
        },
        titles: "Receiver contact used");
    _actionsTakenFormField = dynamicStringFormField(
        initialList: _actionsTaken,
        onSaved: (List<String> changed) {
          _actionsTaken = changed;
          _saveAll();
        },
        titles: "Action taken");
    _contingencyActivitiesFormField = dynamicContingencyActivityFormField(
        initialList: _activities,
        onSaved: (List<ContingencyActivity> changed) {
          _activities = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(ContingencyPlanEvent(
      eventDateAndTime: _eventDateAndTime,
      producerContactsUsed: _producerContactsUsed,
      receiverContactsUsed: _receiverContactsUsed,
      disturbancesIdentified: _disturbancesIdentified,
      activities: _activities,
      actionsTaken: _actionsTaken));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Event Specific Plan"),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ),
        ListTile(
          title: Text("Date and time of event"),
          subtitle: dateTimePicker(
              initialDate: _eventDateAndTime,
              onSaved: (String changed) {
                _eventDateAndTime = DateTime.parse(changed);
                _saveAll();
              }),
        ),
        ListTile(
          title: Text("Producer's emergency contacts used"),
        ),
        _producerContactsUsedFormField,
        ListTile(
          title: Text("Receiver's emergency contacts used"),
        ),
        _receiverContactsUsedFormField,
        StringFormField(
            initial: _disturbancesIdentified,
            isMultiline: true,
            title: "Disturbances identified",
            onSaved: (String changed) {
              _disturbancesIdentified = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
          title: Text(
              "List of animal welfare related measures and actions taken(specific to the event)"),
        ),
        _actionsTakenFormField,
        ListTile(
          title: Text("Carrier's communication activities"),
        ),
        _contingencyActivitiesFormField,
      ],
    );
  }
}
