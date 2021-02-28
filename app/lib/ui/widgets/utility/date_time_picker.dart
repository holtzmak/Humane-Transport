import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

DateTimePicker dateTimePicker(
        {@required DateTime initialDate, @required Function(String) onSaved}) =>
    DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      initialValue: initialDate.toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onSaved: onSaved,
      onChanged: onSaved,
    );

DateTimePicker timePicker(
        {@required TimeOfDay initialTime,
        @required Function(String) onSaved}) =>
    DateTimePicker(
      type: DateTimePickerType.time,
      initialValue: convertTimeOfDayToString(initialTime),
      onSaved: onSaved,
      onChanged: onSaved,
    );

/// The TimeOfDay toString() is not like DateTime toString()
/// This function converts it to the expected string of HH:mm
String convertTimeOfDayToString(TimeOfDay initialTime) =>
    initialTime.toString().substring(10, 15);
