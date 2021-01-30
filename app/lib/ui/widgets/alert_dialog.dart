import 'package:flutter/material.dart';

launchAlertDialog(BuildContext context,
        {String title = "Title", String warning = "Warning"}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(warning),
            ));
