import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/widgets/utility/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class ATRDisplayScreen extends StatefulWidget {
  static const route = "/atrDisplay";
  final List<ExpansionListItem> _displayFields = [];

  ATRDisplayScreen({Key key, AnimalTransportRecord atr}) : super(key: key) {
    _displayFields.addAll([
      ExpansionListItem(
          headerValue: 'Shipper\'s Information',
          expandedValue: atr.shipInfo.toWidget()),
    ]);
  }

  @override
  _ATRDisplayScreenState createState() => _ATRDisplayScreenState();
}

class _ATRDisplayScreenState extends State<ATRDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<HistoryScreenViewModel>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios),
                  onPressed: () => model.navigateToHistoryScreen(),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: _buildExpansionPanels(),
                ),
              ),
            ));
  }

  Widget _buildExpansionPanels() {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget._displayFields[index].isExpanded = !isExpanded;
        });
      },
      children: widget._displayFields.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) =>
              ListTile(title: Text(item.headerValue)),
          body: item.expandedValue,
          isExpanded: item.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }
}
