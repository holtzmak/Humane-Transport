import 'package:flutter/material.dart';

class ExpansionListItem {
  final Widget expandedValue;
  final String headerValue;
  bool isExpanded;

  ExpansionListItem({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });
}
