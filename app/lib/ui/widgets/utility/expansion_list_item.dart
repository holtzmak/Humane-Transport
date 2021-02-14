import 'package:flutter/material.dart';

class ExpansionListItem {
  // TODO: Replace this with a Widget
  final String expandedValue;
  final String headerValue;
  bool isExpanded;

  ExpansionListItem({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });
}
