import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

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
