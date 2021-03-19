import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/contingency_activity_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for ContingencyActivities.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicContingencyActivityFormField(
        {@required List<ContingencyActivity> initialList,
        @required Function(List<ContingencyActivity>) onSaved}) =>
    DynamicFormField<ContingencyActivity>(
        initialList: initialList,
        titles: "Carrier's communication activities",
        onSaved: onSaved,
        blankFieldCreator: () => ContingencyActivity(
            time: DateTime.now(),
            personContacted: "",
            methodOfContact: "",
            instructionsGiven: ""),
        fieldCreator: (int index,
                ContingencyActivity it,
                Function(int, ContingencyActivity) onSaved,
                Optional<Function(int)> onDelete) =>
            ContingencyActivityFormField(
// Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                onSaved: (ContingencyActivity changed) =>
                    onSaved(index, changed),
                onDelete: onDelete.isPresent()
                    ? Optional.of(() => onDelete.get()(index))
                    : Optional.empty()));
