import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class StringFormField extends FormField<String> {
  StringFormField(
      {Key key,
      @required String initial,
      @required String title,
      @required FormFieldSetter<String> onSaved,
      @required Optional<Function()> onDelete,
      FormFieldValidator<String> validator,
      bool isMultiline = false})
      : super(
            key: key,
            initialValue: initial,
            builder: (FormFieldState<String> state) {
              return _StringFormFieldState(
                state: state,
                title: title,
                isMultiline: isMultiline,
                onSaved: onSaved,
                onDelete: onDelete,
                validator: validator,
              );
            });
}

class _StringFormFieldState extends StatelessWidget {
  final ValidationService _validator = locator<ValidationService>();
  final FormFieldState<String> state;
  final String title;
  final bool isMultiline;
  final Optional<Function()> onDelete;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  _StringFormFieldState({
    @required this.state,
    @required this.title,
    @required this.isMultiline,
    @required this.onDelete,
    @required this.onSaved,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return onDelete.isPresent()
        ? ListTile(
            title: TextFormField(
              validator: validator ?? _validator.canBeEmptyFieldValidator,
              initialValue: state.value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: title),
              keyboardType:
                  isMultiline ? TextInputType.multiline : TextInputType.text,
              // Needed for the text field to expand
              maxLines: null,
              onSaved: onSaved,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete.get(),
            ))
        : ListTile(
            title: TextFormField(
              validator: validator ?? _validator.canBeEmptyFieldValidator,
              initialValue: state.value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: title),
              keyboardType:
                  isMultiline ? TextInputType.multiline : TextInputType.text,
              // Needed for the text field to expand
              maxLines: null,
              onSaved: onSaved,
            ),
          );
  }
}
