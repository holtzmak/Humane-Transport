import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/ui/widgets/utility/expansion_list_item.dart';
import 'package:flutter/material.dart';

class AnimalTransportRecordDisplay extends StatefulWidget {
  final List<ExpansionListItem> _atrForDisplay = [];

  AnimalTransportRecordDisplay({Key key, AnimalTransportRecord atr})
      : super(key: key) {
    _atrForDisplay.addAll([
      ExpansionListItem(
          headerValue: 'Shipping Information',
          expandedValue: atr.shipInfo.toString()),
    ]);
  }

  @override
  _AnimalTransportRecordDisplayState createState() =>
      _AnimalTransportRecordDisplayState();
}

class _AnimalTransportRecordDisplayState
    extends State<AnimalTransportRecordDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          // TODO: Replace this with correct nav call
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildExpansionPanels(),
        ),
      ),
    );
  }

  Widget _buildExpansionPanels() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget._atrForDisplay[index].isExpanded = !isExpanded;
        });
      },
      children: widget._atrForDisplay.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              ListTile(title: Text(item.headerValue)),
          body: ListTile(title: Text(item.expandedValue)),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
