import 'package:flutter/material.dart';

// TODO: #134. This class should offer validation for non-empty lists, if desired
// Meaning that the validation function should have optional non-empty check
// if at least one field should exist, and the first item should have no delete button
/// A custom form field for List<T>. Requires widget builder W.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
class DynamicFormField<T, W extends StatefulWidget> extends StatefulWidget {
  final List<T> initialList;
  final String titles;
  final Function(List<T>) onSaved;
  final T Function() blankFieldCreator;
  final W Function(int, T, Function(int, T), Function(int)) fieldCreator;

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  DynamicFormField(
      {Key key,
      @required this.initialList,
      @required this.titles,
      @required this.blankFieldCreator,
      @required this.fieldCreator,
      @required this.onSaved})
      : super(key: key);

  @override
  _DynamicFormFieldState<T, W> createState() => _DynamicFormFieldState<T, W>();
}

class _DynamicFormFieldState<T, W extends StatefulWidget>
    extends State<DynamicFormField<T, W>> {
  final List<T> _fields = [];

  void _saveAll() {
    if (widget.formKey.currentState.validate()) {
      // Calls _saveIndividual for all inner form fields
      widget.formKey.currentState.save();
    }
  }

  void _saveIndividual(int index, T field) {
    _fields[index] = field;
    // TODO: Trim empties from the saved list
    // but keep them in the widget's list to have open spots for new items
    widget.onSaved(_fields);
  }

  void _deleteField(int index) => setState(() {
        _saveAll();
        _fields.removeAt(index);
      });

  void _addField() => setState(() {
        _saveAll();
        _fields.add(widget.blankFieldCreator());
      });

  W _createField(int index) {
    return widget.fieldCreator(
        index, _fields[index], _saveIndividual, _deleteField);
  }

  @override
  void initState() {
    _fields.addAll(widget.initialList.cast<T>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            _fields.isEmpty
                ? Text("No ${widget.titles}, add some using the + button")
                : Container(
                    child: ListView.builder(
                        // Make the List take minimum possible space
                        shrinkWrap: true,
                        // Intended to be used inside existing scroll-ables
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
