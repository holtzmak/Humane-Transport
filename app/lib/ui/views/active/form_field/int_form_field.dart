import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class IntFormField extends StatefulWidget {
  final int initial;
  final String title;
  final Function(int) onSaved;

  IntFormField(
      {Key key,
      @required this.initial,
      @required this.title,
      @required this.onSaved})
      : super(key: key);

  @override
  _IntFormFieldState createState() => _IntFormFieldState();
}

class _IntFormFieldState extends State<IntFormField> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initial.toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        // TODO: This is intensive to do, and should be refactored sometime
        // This is the same as onSaved, so we can avoid needing an
        // explicit save button in dynamic forms
        onChanged: (String changed) => widget.onSaved(int.parse(changed)),
        onSaved: (String changed) => widget.onSaved(int.parse(changed)),
      ),
    );
  }
}
