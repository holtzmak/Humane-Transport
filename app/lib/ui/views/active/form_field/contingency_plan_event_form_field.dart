import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_contingency_activity_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class ContingencyPlanEventFormField extends FormField<ContingencyPlanEvent> {
  ContingencyPlanEventFormField(
      {Key key,
      @required ContingencyPlanEvent initial,
      @required FormFieldSetter<ContingencyPlanEvent> onSaved,
      @required Optional<Function()> onDelete})
      : super(
            key: key,
            onSaved: onSaved,
            initialValue: initial,
            builder: (FormFieldState<ContingencyPlanEvent> state) {
              return _ContingencyPlanEventFormFieldInner(
                initial: state.value,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class _ContingencyPlanEventFormFieldInner extends StatefulWidget {
  final ValidationService _validator = locator<ValidationService>();
  final ContingencyPlanEvent initial;
  final Function(ContingencyPlanEvent) onSaved;
  final Optional<Function()> onDelete;

  _ContingencyPlanEventFormFieldInner(
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
    extends State<_ContingencyPlanEventFormFieldInner> {
  DateTime _eventDateAndTime;
  List<String> _producerContactsUsed;
  List<String> _receiverContactsUsed;
  String _disturbancesIdentified;
  List<ContingencyActivity> _activities;
  List<String> _actionsTaken;

  DynamicFormField<String> _producerContactsUsedFormField;
  DynamicFormField<String> _receiverContactsUsedFormField;
  DynamicFormField<String> _actionsTakenFormField;
  DynamicFormField<ContingencyActivity> _contingencyActivitiesFormField;

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
        canBeEmpty: false,
        initialList: _actionsTaken,
        onSaved: (List<String> changed) {
          _actionsTaken = changed;
          _saveAll();
        },
        titles: "Action taken");
    _contingencyActivitiesFormField = dynamicContingencyActivityFormField(
        canBeEmpty: false,
        initialList: _activities,
        onSaved: (List<ContingencyActivity> changed) {
          _activities = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() {
    widget.onSaved(ContingencyPlanEvent(
        eventDateAndTime: _eventDateAndTime,
        producerContactsUsed: _producerContactsUsed,
        receiverContactsUsed: _receiverContactsUsed,
        disturbancesIdentified: _disturbancesIdentified,
        activities: _activities,
        actionsTaken: _actionsTaken));
  }

  // As the forms are nested, they need to be told to validate
  // Only one call to validate them is needed as this form's fields are validated together
  void _validateNestedForms() {
    _producerContactsUsedFormField.validate();
    _receiverContactsUsedFormField.validate();
    _actionsTakenFormField.validate();
    _contingencyActivitiesFormField.validate();
  }

  // As the forms are nested, they need to be told to saved
  // Only one call to save them is needed as this form's fields are saved together
  void _saveNestedForms() {
    _producerContactsUsedFormField.save();
    _receiverContactsUsedFormField.save();
    _actionsTakenFormField.save();
    _contingencyActivitiesFormField.save();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.onDelete.isPresent()
            ? ListTile(
                title: Text("Event Specific Plan"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: widget.onDelete.get(),
                ),
              )
            : ListTile(
                title: Text("Event Specific Plan"),
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
            validator: (String field) {
              _validateNestedForms();
              return widget._validator.stringFieldValidator(field);
            },
            onSaved: (String changed) {
              _disturbancesIdentified = changed;
              _saveNestedForms();
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
          title: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                  "List of animal welfare related measures and actions taken (specific to the event)")),
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
