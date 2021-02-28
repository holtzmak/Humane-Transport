import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/ui/views/active/form_field/contingency_activity_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dynamic_form_field.dart';

/// A custom form field for ContingencyActivities.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicContingencyActivityFormField(
        {@required List<ContingencyActivity> initialList,
        @required Function(List<ContingencyActivity>) onSaved}) =>
    DynamicFormField<ContingencyActivity, ContingencyActivityFormField>(
        initialList: initialList,
        titles: "Carrier's communication activities",
        onSaved: onSaved,
        blankFieldCreator: () => ContingencyActivity(
            time: TimeOfDay.now(),
            personContacted: "",
            methodOfContact: "",
            instructionsGiven: ""),
        fieldCreator: (int index,
                ContingencyActivity it,
                Function(int, ContingencyActivity) onSaved,
                Function(int) onDelete) =>
            ContingencyActivityFormField(
                // Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                onSaved: (ContingencyActivity changed) =>
                    onSaved(index, changed),
                onDelete: () => onDelete(index)));
