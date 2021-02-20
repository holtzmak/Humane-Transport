import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

/// A custom form field for List<String>
class MultiStringFormField extends StatefulWidget {
  final List<String> initialList;
  final String titles;
  final _MultiStringFormFieldState state = _MultiStringFormFieldState();

  MultiStringFormField(
      {Key key, @required this.initialList, @required this.titles})
      : super(key: key);

  @override
  _MultiStringFormFieldState createState() => state;

  List<String> getList() => state.getList();
}

class _MultiStringFormFieldState extends State<MultiStringFormField> {
  // TODO: #134. This class should offer validation for non-empty lists, if desired
  // Meaning that the validation function should have optional non-empty check
  // if at least one field should exist, and the first item should have no delete button
  final List<StringFormField> _fields = [];

  List<String> getList() => _fields.map((field) => field.getString()).toList();

  void _deleteField(String field) {
    setState(() {
      final find = _fields.firstWhere(
        (it) => it.getString() == field,
        orElse: () => null,
      );
      if (Optional(find).isPresent()) {
        _fields.removeAt(_fields.indexOf(find));
      }
    });
  }

  void _addField(String field) {
    setState(() {
      _fields.add(StringFormField(
          initial: field,
          title: widget.titles,
          onDelete: Optional.of(_deleteField)));
    });
  }

  @override
  void initState() {
    super.initState();
    _fields.addAll(widget.initialList
        .map((it) => StringFormField(
            initial: it,
            title: widget.titles,
            onDelete: Optional.of(_deleteField)))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fields.isEmpty
            ? Text("No fields, try adding some!")
            : Container(
                child: ListView.builder(
                shrinkWrap: true, // Make the List take min possible space
                itemCount: _fields.length,
                itemBuilder: (_, i) => _fields[i],
              )),
        RaisedButton(
          child: Text("Add field"),
          onPressed: () => _addField(""),
        ),
      ],
    );
  }
}
