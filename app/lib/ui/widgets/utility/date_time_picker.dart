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
