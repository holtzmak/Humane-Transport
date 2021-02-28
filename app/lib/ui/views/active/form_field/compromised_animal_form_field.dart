import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class CompromisedAnimalFormField extends StatefulWidget {
  final CompromisedAnimal initial;
  final String title;
  final Function(CompromisedAnimal) onSaved;
  final Function() onDelete;

  CompromisedAnimalFormField(
      {Key key,
      @required this.initial,
      @required this.title,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _CompromisedAnimalFormFieldState createState() =>
      _CompromisedAnimalFormFieldState();
}

class _CompromisedAnimalFormFieldState
    extends State<CompromisedAnimalFormField> {
  String _animalDescription;
  String _measuresTakenToCareForAnimal;

  @override
  void initState() {
    _animalDescription = widget.initial.animalDescription;
    _measuresTakenToCareForAnimal = widget.initial.measuresTakenToCareForAnimal;
    super.initState();
  }

  void _saveAll() => widget.onSaved(CompromisedAnimal(
      animalDescription: _animalDescription,
      measuresTakenToCareForAnimal: _measuresTakenToCareForAnimal));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ),
        StringFormField(
          initial: _animalDescription,
          title: "Animal description",
          onSaved: (String changed) {
            _animalDescription = changed;
            _saveAll();
          },
          onDelete: Optional.empty(),
          isMultiline: true,
        ),
        StringFormField(
          initial: _measuresTakenToCareForAnimal,
          title: "Measures taken to care for animal",
          onSaved: (String changed) {
            _measuresTakenToCareForAnimal = changed;
            _saveAll();
          },
          onDelete: Optional.empty(),
          isMultiline: true,
        )
      ],
    );
  }
}
