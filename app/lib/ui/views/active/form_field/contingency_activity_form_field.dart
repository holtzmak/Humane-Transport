import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class ContingencyActivityFormField extends FormField<ContingencyActivity> {
  ContingencyActivityFormField(
      {Key key,
      @required ContingencyActivity initial,
      @required FormFieldSetter<ContingencyActivity> onSaved,
      @required Optional<Function()> onDelete})
      : super(
            key: key,
            onSaved: onSaved,
            initialValue: initial,
            builder: (FormFieldState<ContingencyActivity> state) {
              return _ContingencyActivityFormFieldInner(
                initial: state.value,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class _ContingencyActivityFormFieldInner extends StatefulWidget {
  final ContingencyActivity initial;
  final Function(ContingencyActivity) onSaved;
  final Optional<Function()> onDelete;

  _ContingencyActivityFormFieldInner(
      {Key key,
      @required this.initial,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _ContingencyActivityFormFieldState createState() =>
      _ContingencyActivityFormFieldState();
}

class _ContingencyActivityFormFieldState
    extends State<_ContingencyActivityFormFieldInner> {
  DateTime _time;
  String _personContacted;
  String _methodOfContact;
  String _instructionsGiven;

  @override
  void initState() {
    _time = widget.initial.time;
    _personContacted = widget.initial.personContacted;
    _methodOfContact = widget.initial.methodOfContact;
    _instructionsGiven = widget.initial.instructionsGiven;
    super.initState();
  }

  void _saveAll() => widget.onSaved(ContingencyActivity(
      time: _time,
      personContacted: _personContacted,
      methodOfContact: _methodOfContact,
      instructionsGiven: _instructionsGiven));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.onDelete.isPresent()
            ? ListTile(
                title: Text("Carrier's communication activity"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: widget.onDelete.get(),
                ),
              )
            : ListTile(
                title: Text("Carrier's communication activity"),
              ),
        ListTile(
          title: Text("Time of communication"),
          subtitle: timePicker(
              initialTime: _time,
              onSaved: (String changed) {
                _time = DateTime.parse(changed);
                _saveAll();
              }),
        ),
        StringFormField(
          initial: _personContacted,
          title: "Who was contacted",
          onSaved: (String changed) {
            _personContacted = changed;
            _saveAll();
          },
          onDelete: Optional.empty(),
        ),
        StringFormField(
            initial: _methodOfContact,
            title: "Communication method used",
            onSaved: (String changed) {
              _methodOfContact = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _instructionsGiven,
            isMultiline: true,
            title:
                "What instructions were given and decisions made with the guidance of emergency contacts reached",
            onSaved: (String changed) {
              _instructionsGiven = changed;
              _saveAll();
            },
            onDelete: Optional.empty())
      ],
    );
  }
}
