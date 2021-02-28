import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_compromised_animal_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/int_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

import 'compromised_animal_form_field.dart';

class AnimalGroupFormField extends StatefulWidget {
  final Function(AnimalGroup info) onSaved;
  final Function() onDelete;
  final AnimalGroup initialInfo;

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  AnimalGroupFormField(
      {Key key,
      @required this.initialInfo,
      @required this.onSaved,
      @required this.onDelete})
      : super(key: key);

  @override
  _AnimalGroupFormFieldState createState() => _AnimalGroupFormFieldState();
}

class _AnimalGroupFormFieldState extends State<AnimalGroupFormField> {
  String _species;
  int _groupAge;
  int _approximateWeight;
  String _animalPurpose;
  int _numberAnimals;
  String _animalsFitForTransport;
  List<CompromisedAnimal> _compromisedAnimals;
  List<CompromisedAnimal> _specialNeedsAnimals;

  DynamicFormField<CompromisedAnimal, CompromisedAnimalFormField>
      _compromisedAnimalsFormField;
  DynamicFormField<CompromisedAnimal, CompromisedAnimalFormField>
      _specialNeedsAnimalsFormField;

  @override
  void initState() {
    _species = widget.initialInfo.species;
    _groupAge = widget.initialInfo.groupAge;
    _approximateWeight = widget.initialInfo.approximateWeight;
    _animalPurpose = widget.initialInfo.animalPurpose;
    _numberAnimals = widget.initialInfo.numberAnimals;
    _animalsFitForTransport =
        widget.initialInfo.animalsFitForTransport ? "Yes" : "No";
    _compromisedAnimals = widget.initialInfo.compromisedAnimals;
    _specialNeedsAnimals = widget.initialInfo.specialNeedsAnimals;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        ListTile(
          title: Text("Species"),
          subtitle: TextFormField(
            initialValue: _species,
            onChanged: (String changed) {
              _species = changed;
              _saveAll();
            },
            onSaved: (String changed) {
              _species = changed;
              _saveAll();
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ),
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
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            title: Text("Are all animals fit for transport?"),
            subtitle: DropdownButtonFormField(
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
        _compromisedAnimalsFormField,
        _specialNeedsAnimalsFormField,
      ]),
    );
  }
}
