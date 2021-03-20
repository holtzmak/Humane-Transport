import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

/// A custom form field for List<T>.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
class DynamicFormField<T> extends StatefulWidget {
  final List<T> initialList;
  final String titles;
  final bool canBeEmpty;
  final Function(List<T>) onSaved;
  final T Function() blankFieldCreator;

  // The fieldCreator uses index, initial, onSaved, and an optional onDelete
  final FormField<T> Function(int, T, Function(int, T), Optional<Function(int)>)
      fieldCreator;
  final _formKey = GlobalKey<FormState>();

  void save() => _formKey.currentState.save();

  bool validate() => _formKey.currentState.validate();

  DynamicFormField(
      {Key key,
      @required this.initialList,
      @required this.titles,
      @required this.blankFieldCreator,
      @required this.fieldCreator,
      @required this.onSaved,
      this.canBeEmpty = true})
      : super(key: key);

  @override
  _DynamicFormFieldState<T> createState() => _DynamicFormFieldState<T>();
}

class _DynamicFormFieldState<T> extends State<DynamicFormField<T>> {
  final List<T> _fields = [];

  void _saveAll() => widget.save();

  void _saveIndividual(int index, T field) {
    _fields[index] = field;
    widget.onSaved(_fields);
  }

  void _deleteField(int index) => setState(() {
        _saveAll();
        if (index == 0 && !widget.canBeEmpty) {
          // do not delete the last field
        } else {
          setState(() {
            _fields.removeAt(index);
          });
        }
      });

  void _addField() => setState(() {
        _saveAll();
        setState(() {
          _fields.add(widget.blankFieldCreator());
        });
      });

  FormField<T> _createField(int index) {
    if (index == 0 && !widget.canBeEmpty) {
      return widget.fieldCreator(
          index, _fields[index], _saveIndividual, Optional.empty());
    } else {
      return widget.fieldCreator(
          index, _fields[index], _saveIndividual, Optional.of(_deleteField));
    }
  }

  @override
  void initState() {
    if (!widget.canBeEmpty && widget.initialList.isEmpty) {
      _fields.add(widget.blankFieldCreator());
    } else {
      _fields.addAll(widget.initialList);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(
          children: [
            _fields.isEmpty
                ? Text("No ${widget.titles}")
                : Column(
                    children: List<FormField<T>>.generate(
                        _fields.length, (int index) => _createField(index))),
            ListTile(
              leading: IconButton(
                tooltip: "Add ${widget.titles} using this (+) button",
                icon: Icon(Icons.add_circle),
                onPressed: _addField,
              ),
              trailing: IconButton(
                tooltip: "Add ${widget.titles} using this (+) button",
                icon: Icon(Icons.help),
                onPressed: () => {
                  // do nothing for help button
                },
              ),
            ),
          ],
        ));
  }
}
