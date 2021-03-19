import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for List<String>.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
dynamicStringFormField(
        {@required List<String> initialList,
        @required String titles,
        @required Function(List<String>) onSaved}) =>
    DynamicFormField<String>(
        initialList: initialList,
        titles: titles,
        onSaved: onSaved,
        blankFieldCreator: () => "",
        fieldCreator: (int index, String it, Function(int, String) onSaved,
                Optional<Function(int)> onDelete) =>
            StringFormField(
// Must have unique keys in rebuilding widget lists
                key: ObjectKey(Uuid().v4()),
                initial: it,
                title: titles,
                onSaved: (String changed) => onSaved(index, changed),
                onDelete: onDelete.isPresent()
                    ? Optional.of(() => onDelete.get()(index))
                    : Optional.empty()));
