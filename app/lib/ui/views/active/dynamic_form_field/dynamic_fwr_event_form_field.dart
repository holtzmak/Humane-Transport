import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/fwr_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for FeedWaterRestEvents.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicFWREventFormField(
        {@required List<FeedWaterRestEvent> initialList,
        @required Function(List<FeedWaterRestEvent>) onSaved}) =>
    DynamicFormField<FeedWaterRestEvent>(
        initialList: initialList,
        titles: "Feed, Water, and Rest event",
        onSaved: onSaved,
        blankFieldCreator: () => FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.now(),
            lastFwrLocation: Address(
                streetAddress: "",
                city: "",
                provinceOrState: "",
                country: "",
                postalCode: ""),
            fwrProvidedOnboard: false),
        fieldCreator: (int index,
                FeedWaterRestEvent it,
                Function(int, FeedWaterRestEvent) onSaved,
                Function(int) onDelete) =>
            FeedWaterRestEventFormField(
                // Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                onSaved: (FeedWaterRestEvent changed) =>
                    onSaved(index, changed),
                onDelete: () => onDelete(index)));
