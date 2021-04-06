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

/// ExpansionPanellist without updates to header
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

/// ExpansionPanellist with option to update headers
class CustomExpansionPanelList extends StatefulWidget {
  final List<ExpansionListItem> items;
  final Function(int, bool) expansionCallback;

  CustomExpansionPanelList(
      {@required this.items, @required this.expansionCallback});

  final _CustomExpansionPanelListState state =
      new _CustomExpansionPanelListState();

  void updateItem(int index, bool isExpanded, bool isSuccessful) =>
      state.updateItem(index, isExpanded, isSuccessful);

  @override
  _CustomExpansionPanelListState createState() => state;
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  List<ExpansionPanel> items = [];

  @override
  void initState() {
    items.addAll(List.generate(
        widget.items.length,
        (index) =>
            _buildPanel(index, NavyBlue, widget.items[index].isExpanded)));
    super.initState();
  }

  void updateItem(int index, bool isExpanded, bool isSuccessful) =>
      setState(() => items[index] = _buildPanel(
          index, isSuccessful ? Colors.green : Colors.red, isExpanded));

  ExpansionPanel _buildPanel(int index, Color color, bool isExpanded) =>
      ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(
            leading: Chip(
              label: Text("${index + 1}",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              shape: StadiumBorder(side: BorderSide(color: color, width: 3.0)),
              backgroundColor: Colors.white,
            ),
            title: Text(
              widget.items[index].headerValue,
              style: TextStyle(color: NavyBlue, fontWeight: FontWeight.bold),
            )),
        body: widget.items[index].expandedValue,
        isExpanded: isExpanded,
        canTapOnHeader: true,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: NavyBlue,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        dividerColor: NavyBlue,
        expansionCallback: widget.expansionCallback,
        children: items,
      ),
    );
  }
}
