import 'package:flutter/material.dart';

/// A class for custom form fields, specifically for grouped fields
/// whose onSaved should collect values from all fields
abstract class GroupFormField<T> extends StatefulWidget {
  final String formName;

  void save();

  const GroupFormField({Key key, @required this.formName}) : super(key: key);
}
