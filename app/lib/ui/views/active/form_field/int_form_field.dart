import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class IntFormField extends FormField<int> {
  IntFormField(
      {Key key,
      @required int initial,
      @required String title,
      @required FormFieldSetter<int> onSaved,
      FormFieldValidator<int> validator})
      : super(
            key: key,
            initialValue: initial,
            builder: (FormFieldState<int> state) {
              return _IntFormFieldState(
                state: state,
                title: title,
                onSaved: onSaved,
                validator: validator,
              );
            });
}

class _IntFormFieldState extends StatelessWidget {
  final ValidationService _validator = locator<ValidationService>();
  final FormFieldState<int> state;
  final String title;
  final FormFieldSetter<int> onSaved;
  final FormFieldValidator<int> validator;

  _IntFormFieldState({
    @required this.state,
    @required this.title,
    @required this.onSaved,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        initialValue: state.value.toString(),
        validator: (String field) {
          if (validator != null) {
            return validator(int.tryParse(field));
          } else {
            return _validator.nonNullIntFieldValidator(int.tryParse(field));
          }
        },
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: title),
        keyboardType: TextInputType.number,
        onSaved: (String changed) => onSaved(int.parse(changed)),
      ),
    );
  }
}
