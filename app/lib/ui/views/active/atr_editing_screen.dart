import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/active/form_field/acknowledgement_info_form_field.dart';
import 'package:app/ui/views/active/form_field/contingency_plan_info_form_field.dart';
import 'package:app/ui/views/active/form_field/delivery_info_form_field.dart';
import 'package:app/ui/views/active/form_field/loading_vehicle_info_form_field.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/views/active/form_field/transporter_info_form_field.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

import 'form_field/fwr_info_form_field.dart';

class ATREditingScreen extends StatefulWidget {
  static const route = "/atrEditingScreen";
  final AnimalTransportRecord atr;

  ATREditingScreen({Key key, @required this.atr}) : super(key: key);

  @override
  _ATREditingScreenState createState() => _ATREditingScreenState();
}

class _ATREditingScreenState extends State<ATREditingScreen> {
  AnimalTransportRecord _replacementAtr;
  final List<ExpansionListItem> _atrFormFieldsWrapper = [];

  ShipperInfoFormField _shipperInfoField;
  TransporterInfoFormField _transporterInfoFormField;
  FeedWaterRestInfoFormField _feedWaterRestInfoFormField;
  LoadingVehicleInfoFormField _loadingVehicleInfoFormField;
  DeliveryInfoFormField _deliveryInfoFormField;
  AcknowledgementInfoFormField _acknowledgementInfoFormField;
  ContingencyPlanInfoFormField _contingencyPlanInfoFormField;

  @override
  void initState() {
    super.initState();
    _replacementAtr = widget.atr;

    _shipperInfoField = ShipperInfoFormField(
        initialInfo: _replacementAtr.shipInfo,
        onSaved: (ShipperInfo newInfo) =>
            _replacementAtr = _replacementAtr.withShipInfo(newInfo));
    _transporterInfoFormField = TransporterInfoFormField(
        initialInfo: _replacementAtr.tranInfo,
        onSaved: (TransporterInfo newInfo) =>
            _replacementAtr = _replacementAtr.withTransporterInfo(newInfo));
    _feedWaterRestInfoFormField = FeedWaterRestInfoFormField(
        initialInfo: _replacementAtr.fwrInfo,
        onSaved: (FeedWaterRestInfo newInfo) =>
            _replacementAtr = _replacementAtr.withFwrInfo(newInfo));
    _loadingVehicleInfoFormField = LoadingVehicleInfoFormField(
        initialInfo: _replacementAtr.vehicleInfo,
        onSaved: (LoadingVehicleInfo newInfo) =>
            _replacementAtr = _replacementAtr.withVehicleInfo(newInfo));
    _deliveryInfoFormField = DeliveryInfoFormField(
      initialInfo: _replacementAtr.deliveryInfo,
      onSaved: (DeliveryInfo newInfo) =>
          _replacementAtr = _replacementAtr.withDeliveryInfo(newInfo),
    );
    _acknowledgementInfoFormField = AcknowledgementInfoFormField(
      initialInfo: _replacementAtr.ackInfo,
      onSaved: (AcknowledgementInfo newInfo) =>
          _replacementAtr = _replacementAtr.withAckInfo(newInfo),
    );
    _contingencyPlanInfoFormField = ContingencyPlanInfoFormField(
      initialInfo: _replacementAtr.contingencyInfo,
      onSaved: (ContingencyPlanInfo newInfo) =>
          _replacementAtr = _replacementAtr.withContingencyInfo(newInfo),
    );

    _atrFormFieldsWrapper.addAll([
      ExpansionListItem(
          expandedValue: _shipperInfoField,
          headerValue: _shipperInfoField.title),
      ExpansionListItem(
          expandedValue: _transporterInfoFormField,
          headerValue: _transporterInfoFormField.title),
      ExpansionListItem(
          expandedValue: _feedWaterRestInfoFormField,
          headerValue: _feedWaterRestInfoFormField.title),
      ExpansionListItem(
          expandedValue: _loadingVehicleInfoFormField,
          headerValue: _loadingVehicleInfoFormField.title),
      ExpansionListItem(
          expandedValue: _deliveryInfoFormField,
          headerValue: _deliveryInfoFormField.title),
      ExpansionListItem(
          expandedValue: _acknowledgementInfoFormField,
          headerValue: _acknowledgementInfoFormField.title),
      ExpansionListItem(
          expandedValue: _contingencyPlanInfoFormField,
          headerValue: _contingencyPlanInfoFormField.title)
    ]);
  }

  bool _formIsValid() =>
      _shipperInfoField.formKey.currentState.validate() &&
      _transporterInfoFormField.formKey.currentState.validate() &&
      _feedWaterRestInfoFormField.formKey.currentState.validate() &&
      _loadingVehicleInfoFormField.formKey.currentState.validate() &&
      _deliveryInfoFormField.formKey.currentState.validate() &&
      _acknowledgementInfoFormField.formKey.currentState.validate() &&
      _contingencyPlanInfoFormField.formKey.currentState.validate();

  bool _canAndDidFormSave() {
    if (_formIsValid()) {
      _shipperInfoField.formKey.currentState.save();
      _transporterInfoFormField.formKey.currentState.save();
      _feedWaterRestInfoFormField.formKey.currentState.save();
      _loadingVehicleInfoFormField.formKey.currentState.save();
      _deliveryInfoFormField.formKey.currentState.save();
      _acknowledgementInfoFormField.formKey.currentState.save();
      _contingencyPlanInfoFormField.formKey.currentState.save();
      return true;
    }
    return false;
  }

  Future<bool> _saveATR(ActiveScreenViewModel model) async =>
      Future.value(_canAndDidFormSave())
          .then((_) => model.saveEditedAtr(_replacementAtr))
          .then((_) => true)
          .catchError((_) => false);

  Future<void> _submitATR(ActiveScreenViewModel model) async =>
      Future.value(_canAndDidFormSave())
          .then((_) => model.saveCompletedAtr(_replacementAtr));

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ActiveScreenViewModel>(
        builder: (context, model, child) => WillPopScope(
              onWillPop: () => _saveATR(model),
              child: BusyOverlayScreen(
                show: model.state == ViewState.Busy,
                child: Scaffold(
                    appBar: AppBar(
                      title: Text("Animal Transport Form"),
                      automaticallyImplyLeading: false,
                      leading: new IconButton(
                        icon: new Icon(Icons.arrow_back_ios),
                        onPressed: () async => _saveATR(model)
                            .then((value) => model.navigateBack()),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              child: buildExpansionPanelList(
                                  expansionCallback:
                                      (int index, bool isExpanded) {
                                    setState(() {
                                      _atrFormFieldsWrapper[index].isExpanded =
                                          !isExpanded;
                                    });
                                  },
                                  items: _atrFormFieldsWrapper)),
                          RaisedButton(
                            child: Text("Submit"),
                            onPressed: () async => _submitATR(model),
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }
}
