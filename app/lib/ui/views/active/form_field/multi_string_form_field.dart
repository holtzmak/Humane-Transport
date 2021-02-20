import 'package:app/core/utilities/optional.dart';
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

/// A custom form field with onDelete callback
class StringFormField extends StatefulWidget {
  final String initial;
  final String title;
  final Optional<Function(String)> onDelete;
  final _StringFormFieldState state = _StringFormFieldState();

  StringFormField(
      {Key key,
      @required this.initial,
      @required this.title,
      @required this.onDelete})
      : super(key: key);

  @override
  _StringFormFieldState createState() => state;

  String getString() => state.getString();
}

class _StringFormFieldState extends State<StringFormField> {
  TextEditingController _textController;

  String getString() => _textController.text;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onDelete.isPresent()
        ? ListTile(
            title: Text(widget.title),
            subtitle: TextFormField(
              controller: _textController,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => widget.onDelete.get()(getString()),
            ),
          )
        : ListTile(
            title: Text(widget.title),
            subtitle: TextFormField(
              controller: _textController,
            ),
          );
  }
}
