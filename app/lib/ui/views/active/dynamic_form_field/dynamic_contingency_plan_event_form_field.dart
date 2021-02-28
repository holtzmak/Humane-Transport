import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dynamic_form_field.dart';

/// A custom form field for ContingencyPlanEvents.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicContingencyPlanEventFormField(
        {@required List<ContingencyPlanEvent> initialList,
        @required Function(List<ContingencyPlanEvent>) onSaved}) =>
    DynamicFormField<ContingencyPlanEvent, ContingencyPlanEventFormField>(
        initialList: initialList,
        titles: "Event Specific Plans",
        onSaved: onSaved,
        blankFieldCreator: () => ContingencyPlanEvent(
            eventDateAndTime: DateTime.now(),
            producerContactsUsed: [],
            receiverContactsUsed: [],
            disturbancesIdentified: "",
            activities: [],
            actionsTaken: []),
        fieldCreator: (int index,
                ContingencyPlanEvent it,
                Function(int, ContingencyPlanEvent) onSaved,
                Function(int) onDelete) =>
            ContingencyPlanEventFormField(
                // Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                onSaved: (ContingencyPlanEvent changed) =>
                    onSaved(index, changed),
                onDelete: () => onDelete(index)));
