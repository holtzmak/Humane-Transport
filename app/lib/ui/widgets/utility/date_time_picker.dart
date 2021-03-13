import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

DateTimePicker dateTimePicker(
        {@required DateTime initialDate, @required Function(String) onSaved}) =>
    DateTimePicker(
      decoration: InputDecoration(border: OutlineInputBorder()),
      type: DateTimePickerType.dateTimeSeparate,
      initialValue: initialDate.toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onSaved: onSaved,
      onChanged: onSaved,
    );

DateTimePicker timePicker(
        {@required DateTime initialTime, @required Function(String) onSaved}) =>
    DateTimePicker(
      decoration: InputDecoration(border: OutlineInputBorder()),
      type: DateTimePickerType.time,
      initialValue: DateFormat('HH:mm').format(initialTime),
      onSaved: (String changed) => onSaved("1970-01-01 $changed"),
      onChanged: (String changed) => onSaved("1970-01-01 $changed"),
    );
