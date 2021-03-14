import 'package:app/ui/common/style.dart';
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

Widget buildExpansionPanelList(
    {@required Function(int, bool) expansionCallback,
    @required List<ExpansionListItem> items}) {
  return ExpansionPanelList(
    expandedHeaderPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
    expansionCallback: expansionCallback,
    children: items.map<ExpansionPanel>((item) {
      return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(
            title: Text(
          item.headerValue,
          style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
        )),
        body: item.expandedValue,
        isExpanded: item.isExpanded,
        canTapOnHeader: true,
      );
    }).toList(),
  );
}
