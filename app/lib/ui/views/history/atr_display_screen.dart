import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/common/style.dart';

class ATRDisplayScreen extends StatefulWidget {
  static const route = "/atrDisplayScreen";
  final List<ExpansionListItem> _displayFields = [];

  ATRDisplayScreen({Key key, @required AnimalTransportRecord atr})
      : super(key: key) {
    _displayFields.addAll([
      ExpansionListItem(
          headerValue: 'Shipper\'s Information',
          expandedValue: atr.shipInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Transporter\'s Information',
          expandedValue: atr.tranInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Feed, Water, and Rest Information',
          expandedValue: atr.fwrInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Loading Vehicle Information',
          expandedValue: atr.vehicleInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Delivery Information',
          expandedValue: atr.deliveryInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Acknowledgements',
          expandedValue: atr.ackInfo.toWidget()),
      ExpansionListItem(
          headerValue: 'Contingency Plan',
          expandedValue: atr.contingencyInfo.toWidget()),
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
              backgroundColor: Beige,
              appBar: AppBar(
                iconTheme: IconThemeData(color: NavyBlue),
                backgroundColor: White,
                actions: [
                  OutlinedButton.icon(
                      onPressed: model.navigateToPDFScreen,
                      icon: Icon(Icons.share_outlined, color: NavyBlue),
                      label: Text(
                        'Share as PDF',
                        style: TextStyle(color: NavyBlue),
                      ))
                ],
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: model.navigateToHistoryScreen,
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: buildExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          widget._displayFields[index].isExpanded = !isExpanded;
                        });
                      },
                      items: widget._displayFields),
                ),
              ),
            ));
  }
}
