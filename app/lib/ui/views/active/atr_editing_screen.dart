import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/views/active/form_field/group_form_field.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATREditingScreen extends StatefulWidget {
  final DialogService _dialogService = locator<DialogService>();
  static const route = "/atrEditingScreen";
  final AnimalTransportRecord atr;

  ATREditingScreen({Key key, @required this.atr}) : super(key: key);

  @override
  _ATREditingScreenState createState() => _ATREditingScreenState();
}

class _ATREditingScreenState extends State<ATREditingScreen> {
  List<GroupFormField> atrFormFields = [];
  List<ExpansionListItem> atrFormFieldsWrapper = [];
  AnimalTransportRecord _replacementAtr;

  @override
  void initState() {
    super.initState();
    _replacementAtr = widget.atr;
    atrFormFields = [
      ShipperInfoFormField(
          initialInfo: _replacementAtr.shipInfo,
          onSaved: (ShipperInfo newInfo) =>
              _replacementAtr = _replacementAtr.withShipInfo(newInfo))
    ];
    atrFormFieldsWrapper = atrFormFields
        .map((field) => ExpansionListItem(
            expandedValue: field, headerValue: field.formName))
        .toList();
  }

  void _submitATR(List<GroupFormField> fields) {
    fields.forEach((groupField) => groupField.save());
    // TODO: Call service and submit the completed atr
    // TODO: Call service and remove the incomplete atr
    widget._dialogService.showDialog(
        title: "Animal Transport Form Submitted",
        description:
            '${DateFormat("yyyy-MM-dd hh:mm").format(_replacementAtr.vehicleInfo.dateAndTimeLoaded)}');
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ActiveScreenViewModel>(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Animal Transport Form"),
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: model.navigateToActiveScreen,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: buildExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            atrFormFieldsWrapper[index].isExpanded =
                                !isExpanded;
                          });
                        },
                        items: atrFormFieldsWrapper)),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () => _submitATR(atrFormFields),
                ),
              ],
            ),
          )),
    );
  }
}
