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
  return Container(
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: NavyBlue, borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child: ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: NavyBlue,
      expansionCallback: expansionCallback,
      children: items
          .asMap()
          .map((index, item) {
            return MapEntry(
                index,
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => ListTile(
                      leading: Chip(
                        label: Text("${index + 1}",
                            style: TextStyle(
                                color: NavyBlue, fontWeight: FontWeight.bold)),
                        shape: StadiumBorder(
                            side: BorderSide(color: NavyBlue, width: 3.0)),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        item.headerValue,
                        style: TextStyle(
                            color: NavyBlue, fontWeight: FontWeight.bold),
                      )),
                  body: item.expandedValue,
                  isExpanded: item.isExpanded,
                  canTapOnHeader: true,
                ));
          })
          .values
          .toList(),
    ),
  );
}
