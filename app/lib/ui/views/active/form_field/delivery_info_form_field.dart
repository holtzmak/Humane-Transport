import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_compromised_animal_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/receiver_info_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

class DeliveryInfoFormField extends StatefulWidget {
  final Function(DeliveryInfo info) onSaved;
  final DeliveryInfo initialInfo;
  final String title = "Delivery Information";
  final _innerFormKey = GlobalKey<FormState>();

  void save() => _innerFormKey.currentState.save();

  // This function does not change the state of the widget
  // Must call validate within widget for error text to appear
  bool validate() => _innerFormKey.currentState.validate();

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
  DynamicFormField<CompromisedAnimal> _compromisedAnimalsFormField;

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

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() => _compromisedAnimalsFormField.save();

  void _saveAll() => widget.onSaved(DeliveryInfo(
      recInfo: _receiverInfo,
      arrivalDateAndTime: _arrivalDateAndTime,
      compromisedAnimals: _compromisedAnimals,
      additionalWelfareConcerns: _additionalWelfareConcerns));

  void _validateAndSaveAll() {
    // Do not short-circuit the validation calls using &&
    final isFormValid = widget._innerFormKey.currentState.validate();
    final isInnerFormValid = _compromisedAnimalsFormField.validate();
    if (isFormValid && isInnerFormValid) widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._innerFormKey,
      child: Column(children: [
        ListTile(
          title: outlinedTextContainer(
              textColor: White,
              borderColor: NavyBlue,
              backgroundColor: NavyBlue,
              text: "Receiver Info"),
          subtitle: _receiverInfoFormField,
        ),
        ListTile(
            title: outlinedTextContainer(
                textColor: White,
                borderColor: NavyBlue,
                backgroundColor: NavyBlue,
                text: "Date and time of arrival"),
            subtitle: dateTimePicker(
                initialDate: _arrivalDateAndTime,
                onSaved: (String changed) {
                  _arrivalDateAndTime = DateTime.parse(changed);
                  _saveAll();
                })),
        Divider(
          color: NavyBlue,
          thickness: 4.0,
        ),
        ListTile(
            title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "If any animals did not arrive in good condition",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        _compromisedAnimalsFormField,
        Divider(
          color: NavyBlue,
          thickness: 4.0,
        ),
        StringFormField(
            initial: _additionalWelfareConcerns,
            isMultiline: true,
            title:
                "Additional animal welfare concerns for the consignee to be aware of?",
            onSaved: (String changed) {
              _additionalWelfareConcerns = changed;
              _saveNestedForms();
              _saveAll();
            },
            onDelete: Optional.empty()),
        RaisedButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _validateAndSaveAll)
      ]),
    );
  }
}
