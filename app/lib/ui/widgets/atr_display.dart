import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/ui/widgets/utility/expansion_list_item.dart';
import 'package:flutter/material.dart';

class ATRDisplay extends StatefulWidget {
  final List<ExpansionListItem> _displayFields = [];

  ATRDisplay({Key key, AnimalTransportRecord atr}) : super(key: key) {
    _displayFields.addAll([
      ExpansionListItem(
          headerValue: 'Shipper\'s Information',
          expandedValue: atr.shipInfo.toString()),
      ExpansionListItem(
          headerValue: 'Transporter\'s Information',
          expandedValue: atr.tranInfo.toString()),
      ExpansionListItem(
          headerValue: 'Feed, Water, and Rest Information',
          expandedValue: atr.fwrInfo.toString()),
      ExpansionListItem(
          headerValue: 'Loading Vehicle Information',
          expandedValue: atr.vehicleInfo.toString()),
      ExpansionListItem(
          headerValue: 'Delivery Information',
          expandedValue: atr.deliveryInfo.toString()),
      ExpansionListItem(
          headerValue: 'Acknowledgements',
          expandedValue: atr.ackInfo.toString()),
      ExpansionListItem(
          headerValue: 'Contingency Plan',
          expandedValue: atr.contingencyInfo.toString()),
    ]);
  }

  @override
  _ATRDisplayState createState() => _ATRDisplayState();
}

class _ATRDisplayState extends State<ATRDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          // TODO: Replace this with correct nav service
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
          widget._displayFields[index].isExpanded = !isExpanded;
        });
      },
      children: widget._displayFields.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              ListTile(title: Text(item.headerValue)),
          // TODO: Replace body with a custom widget
          body: ListTile(title: Text(item.expandedValue)),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
