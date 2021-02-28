import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_compromised_animal_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/compromised_animal_form_field.dart';
import 'package:app/ui/views/active/form_field/receiver_info_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

class DeliveryInfoFormField extends StatefulWidget {
  final Function(DeliveryInfo info) onSaved;
  final DeliveryInfo initialInfo;
  final String title = "Delivery Information";

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  DeliveryInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _DeliveryInfoFormFieldState createState() => _DeliveryInfoFormFieldState();
}

class _DeliveryInfoFormFieldState extends State<DeliveryInfoFormField> {
  ReceiverInfo _receiverInfo;
  DateTime _arrivalDateAndTime;
  List<CompromisedAnimal> _compromisedAnimals;
  String _additionalWelfareConcerns;

  ReceiverInfoFormField _receiverInfoFormField;
  DynamicFormField<CompromisedAnimal, CompromisedAnimalFormField>
      _compromisedAnimalsFormField;

  @override
  void initState() {
    _receiverInfo = widget.initialInfo.recInfo;
    _arrivalDateAndTime = widget.initialInfo.arrivalDateAndTime;
    _compromisedAnimals = widget.initialInfo.compromisedAnimals;
    _additionalWelfareConcerns = widget.initialInfo.additionalWelfareConcerns;
    _receiverInfoFormField = ReceiverInfoFormField(
        initialInfo: _receiverInfo,
        onSaved: (ReceiverInfo changed) {
          _receiverInfo = changed;
          _saveAll();
        });
    _compromisedAnimalsFormField = dynamicCompromisedAnimalFormField(
        initialList: _compromisedAnimals,
        titles: "Compromised animal",
        onSaved: (List<CompromisedAnimal> changed) {
          _compromisedAnimals = changed;
          _saveAll();
        });
    super.initState();
  }

  void _saveAll() => widget.onSaved(DeliveryInfo(
      recInfo: _receiverInfo,
      arrivalDateAndTime: _arrivalDateAndTime,
      compromisedAnimals: _compromisedAnimals,
      additionalWelfareConcerns: _additionalWelfareConcerns));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        ListTile(
          title: Text("Receiver Info"),
          subtitle: _receiverInfoFormField,
        ),
        ListTile(
            title: Text("Date and time of arrival"),
            subtitle: dateTimePicker(
                initialDate: _arrivalDateAndTime,
                onSaved: (String changed) {
                  _arrivalDateAndTime = DateTime.parse(changed);
                  _saveAll();
                })),
        ListTile(
            title: Text(
                "If any animals did not arrive in good condition\nDescription of transport related conditions and actions taken to address prior to arrival")),
        _compromisedAnimalsFormField,
        StringFormField(
            initial: _additionalWelfareConcerns,
            isMultiline: true,
            title:
                "Additional animal welfare concerns for the consignee to be aware of?",
            onSaved: (String changed) {
              _additionalWelfareConcerns = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        RaisedButton(child: Text("Save"), onPressed: _saveAll)
      ]),
    );
  }
}
