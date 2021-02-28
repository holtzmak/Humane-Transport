import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/ui/views/active/form_field/animal_group_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dynamic_form_field.dart';

/// A custom form field for AnimalGroups.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicAnimalGroupFormField(
        {@required List<AnimalGroup> initialList,
        @required Function(List<AnimalGroup>) onSaved}) =>
    DynamicFormField<AnimalGroup, AnimalGroupFormField>(
        initialList: initialList,
        titles: "Animal(s) description",
        onSaved: onSaved,
        blankFieldCreator: () => AnimalGroup(
            species: "",
            groupAge: 0,
            approximateWeight: 0,
            animalPurpose: "",
            numberAnimals: 0,
            animalsFitForTransport: true,
            compromisedAnimals: [],
            specialNeedsAnimals: []),
        fieldCreator: (int index, AnimalGroup it,
                Function(int, AnimalGroup) onSaved, Function(int) onDelete) =>
            AnimalGroupFormField(
                // Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initialInfo: it,
                onSaved: (AnimalGroup changed) => onSaved(index, changed),
                onDelete: () => onDelete(index)));
