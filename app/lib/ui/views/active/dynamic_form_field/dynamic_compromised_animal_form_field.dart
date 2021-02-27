import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/ui/views/active/form_field/compromised_animal_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dynamic_form_field.dart';

/// A custom form field for CompromisedAnimals.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicCompromisedAnimalFormField(
        {@required List<CompromisedAnimal> initialList,
        @required String titles,
        @required Function(List<CompromisedAnimal>) onSaved}) =>
    DynamicFormField<CompromisedAnimal, CompromisedAnimalFormField>(
        initialList: initialList,
        titles: titles,
        onSaved: onSaved,
        blankFieldCreator: () => CompromisedAnimal(
            animalDescription: "", measuresTakenToCareForAnimal: ""),
        fieldCreator: (int index,
                CompromisedAnimal it,
                Function(int, CompromisedAnimal) onSaved,
                Function(int) onDelete) =>
            CompromisedAnimalFormField(
                // Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                onSaved: (CompromisedAnimal changed) => onSaved(index, changed),
                onDelete: () => onDelete(index)));
