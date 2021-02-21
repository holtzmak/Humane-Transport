import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class StringFormField extends StatefulWidget {
  final String initial;
  final String title;
  final FormFieldSetter<String> onSaved;
  final Optional<Function()> onDelete;

  StringFormField(
      {Key key,
      @required this.initial,
      @required this.title,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _StringFormFieldState createState() => _StringFormFieldState();
}

class _StringFormFieldState extends State<StringFormField> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initial);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onDelete.isPresent()
        ? ListTile(
            title: Text(widget.title),
            subtitle: TextFormField(
              controller: controller,
              // This is the same as onSaved, so we can avoid needing an
              // explicit save button in dynamic forms
              onChanged: widget.onSaved,
              onSaved: widget.onSaved,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: widget.onDelete.get(),
            ),
          )
        : ListTile(
            title: Text(widget.title),
            subtitle: TextFormField(
              controller: controller,
              onSaved: widget.onSaved,
              onChanged: widget.onSaved,
            ),
          );
  }
}
