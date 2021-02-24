import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// TODO: #134. This class should offer validation for non-empty lists, if desired
// Meaning that the validation function should have optional non-empty check
// if at least one field should exist, and the first item should have no delete button
/// A custom form field for List<String>
class DynamicStringFormField extends StatefulWidget {
  final List<String> initialList;
  final String titles;
  final Function(List<String>) onSaved;

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  DynamicStringFormField(
      {Key key,
      @required this.initialList,
      @required this.titles,
      @required this.onSaved})
      : super(key: key);

  @override
  _DynamicStringFormFieldState createState() => _DynamicStringFormFieldState();
}

class _DynamicStringFormFieldState extends State<DynamicStringFormField> {
  final List<String> _fields = [];

  void _saveAll() {
    if (widget.formKey.currentState.validate()) {
      // Calls _saveIndividual for all inner form fields
      widget.formKey.currentState.save();
    }
  }

  void _saveIndividual(int index, String field) {
    _fields[index] = field;
    // TODO: Trim empty strings from the saved list
    // but keep them in the widget's list to have open spots for new items
    widget.onSaved(_fields);
  }

  void _deleteField(int index) => setState(() {
        _saveAll();
        _fields.removeAt(index);
      });

  void _addField() => setState(() {
        _saveAll();
        _fields.add("");
      });

  StringFormField _createField(int index) {
    return StringFormField(
        // Must have unique keys in rebuilding widget lists
        key: ObjectKey(Uuid().v4()),
        initial: _fields[index],
        title: widget.titles,
        onSaved: (String changed) => _saveIndividual(index, changed),
        onDelete: Optional.of(() => _deleteField(index)));
  }

  @override
  void initState() {
    _fields.addAll(widget.initialList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            _fields.isEmpty
                ? Text("No fields, try adding some!")
                : Container(
                    child: ListView.builder(
                        // Make the List take minimum possible space
                        shrinkWrap: true,
                        // Intended to be used inside existing scrollables
                        primary: false,
                        itemCount: _fields.length,
                        itemBuilder: (_, index) => _createField(index))),
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
