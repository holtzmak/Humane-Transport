import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_compromised_animal_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/int_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

/// A custom form field with onSaved and onDelete callback
class AnimalGroupFormField extends FormField<AnimalGroup> {
  AnimalGroupFormField(
      {Key key,
      @required AnimalGroup initial,
      @required FormFieldSetter<AnimalGroup> onSaved,
      @required Optional<Function()> onDelete})
      : super(
            key: key,
            initialValue: initial,
            builder: (FormFieldState<AnimalGroup> state) {
              return _AnimalGroupFormFieldInner(
                initial: state.value,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class _AnimalGroupFormFieldInner extends StatefulWidget {
  final ValidationService _validator = locator<ValidationService>();
  final Function(AnimalGroup info) onSaved;
  final Optional<Function()> onDelete;
  final AnimalGroup initial;

  _AnimalGroupFormFieldInner(
      {Key key,
      @required this.initial,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _AnimalGroupFormFieldState createState() => _AnimalGroupFormFieldState();
}

class _AnimalGroupFormFieldState extends State<_AnimalGroupFormFieldInner> {
  String _species;
  int _groupAge;
  int _approximateWeight;
  String _animalPurpose;
  int _numberAnimals;
  String _animalsFitForTransport;
  List<CompromisedAnimal> _compromisedAnimals;
  List<CompromisedAnimal> _specialNeedsAnimals;

  DynamicFormField<CompromisedAnimal> _compromisedAnimalsFormField;
  DynamicFormField<CompromisedAnimal> _specialNeedsAnimalsFormField;

  @override
  void initState() {
    _species = widget.initial.species;
    _groupAge = widget.initial.groupAge;
    _approximateWeight = widget.initial.approximateWeight;
    _animalPurpose = widget.initial.animalPurpose;
    _numberAnimals = widget.initial.numberAnimals;
    _animalsFitForTransport =
        widget.initial.animalsFitForTransport ? "Yes" : "No";
    _compromisedAnimals = widget.initial.compromisedAnimals;
    _specialNeedsAnimals = widget.initial.specialNeedsAnimals;
    _compromisedAnimalsFormField = dynamicCompromisedAnimalFormField(
        initialList: _compromisedAnimals,
        titles: "Compromised animal",
        onSaved: (List<CompromisedAnimal> changed) {
          _compromisedAnimals = changed;
          _saveAll();
        });
    _specialNeedsAnimalsFormField = dynamicCompromisedAnimalFormField(
        initialList: _specialNeedsAnimals,
        titles: "Special needs animal",
        onSaved: (List<CompromisedAnimal> changed) {
          _specialNeedsAnimals = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(AnimalGroup(
      species: _species,
      groupAge: _groupAge,
      approximateWeight: _approximateWeight,
      animalPurpose: _animalPurpose,
      numberAnimals: _numberAnimals,
      animalsFitForTransport: _animalsFitForTransport == "Yes" ? true : false,
      compromisedAnimals: _compromisedAnimals,
      specialNeedsAnimals: _specialNeedsAnimals));

  // As the forms are nested, they need to be told to validate
  // Only one call to validate them is needed as this form's fields are validated together
  void _validateNestedForms() {
    _compromisedAnimalsFormField.validate();
    _specialNeedsAnimalsFormField.validate();
  }

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() {
    _compromisedAnimalsFormField.save();
    _specialNeedsAnimalsFormField.save();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.onDelete.isPresent()
          ? ListTile(
              title: Text("Animal Group"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: widget.onDelete.get(),
              ),
            )
          : ListTile(
              title: Text("Animal Group"),
            ),
      StringFormField(
          initial: _species,
          title: "Species",
          validator: (String field) {
            _validateNestedForms();
            return widget._validator.stringFieldValidator(field);
          },
          onSaved: (String changed) {
            _species = changed;
            _saveNestedForms();
            _saveAll();
          },
          onDelete: Optional.empty()),
      IntFormField(
          initial: _groupAge,
          title: "Approximate group age",
          onSaved: (int changed) {
            _groupAge = changed;
            _saveAll();
          }),
      IntFormField(
          initial: _approximateWeight,
          title: "Approximate group weight",
          onSaved: (int changed) {
            _approximateWeight = changed;
            _saveAll();
          }),
      StringFormField(
          initial: _animalPurpose,
          title: "Purpose of the animals",
          onSaved: (String changed) {
            _animalPurpose = changed;
            _saveAll();
          },
          onDelete: Optional.empty()),
      IntFormField(
          initial: _numberAnimals,
          title: "Number of animals on the transport",
          onSaved: (int changed) {
            _numberAnimals = changed;
            _saveAll();
          }),
      ListTile(
          title: DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Are all animals fit for transport?"),
        value: _animalsFitForTransport,
        items: ["Yes", "No"]
            .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
            .toList(),
        onChanged: (String changed) => setState(() {
          _animalsFitForTransport = changed;
          _saveAll();
        }),
      )),
      ListTile(
        title: Text("If there are any compromised animals"),
      ),
      _compromisedAnimalsFormField,
      ListTile(
        title: Text("If there are any special needs animals"),
      ),
      _specialNeedsAnimalsFormField,
    ]);
  }
}
