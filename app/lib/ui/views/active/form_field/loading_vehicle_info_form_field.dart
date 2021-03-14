import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_animal_group_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/form_field/int_form_field.dart';
import 'package:app/ui/widgets/utility/date_time_picker.dart';
import 'package:flutter/material.dart';

class LoadingVehicleInfoFormField extends StatefulWidget {
  final Function(LoadingVehicleInfo info) onSaved;
  final LoadingVehicleInfo initialInfo;
  final String title = "Loading Vehicle Information";
  final _innerFormKey = GlobalKey<FormState>();

  void save() => _innerFormKey.currentState.save();

  // This function does not change the state of the widget
  // Must call validate within widget for error text to appear
  bool validate() => _innerFormKey.currentState.validate();

  LoadingVehicleInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _LoadingVehicleInfoFormFieldState createState() =>
      _LoadingVehicleInfoFormFieldState();
}

class _LoadingVehicleInfoFormFieldState
    extends State<LoadingVehicleInfoFormField> {
  DateTime _dateAndTimeLoaded;
  int _loadingArea;
  int _loadingDensity;
  int _animalsPerLoadingArea;
  List<AnimalGroup> _animalsLoaded;

  DynamicFormField<AnimalGroup> _animalsLoadedFormField;

  @override
  void initState() {
    _dateAndTimeLoaded = widget.initialInfo.dateAndTimeLoaded;
    _loadingArea = widget.initialInfo.loadingArea;
    _loadingDensity = widget.initialInfo.loadingDensity;
    _animalsPerLoadingArea = widget.initialInfo.animalsPerLoadingArea;
    _animalsLoaded = widget.initialInfo.animalsLoaded;
    _animalsLoadedFormField = dynamicAnimalGroupFormField(
        initialList: _animalsLoaded,
        onSaved: (List<AnimalGroup> changed) {
          _animalsLoaded = changed;
          _saveAll();
        });
    super.initState();
  }

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() => _animalsLoadedFormField.save();

  void _saveAll() => widget.onSaved(LoadingVehicleInfo(
      dateAndTimeLoaded: _dateAndTimeLoaded,
      loadingArea: _loadingArea,
      loadingDensity: _loadingDensity,
      animalsPerLoadingArea: _animalsPerLoadingArea,
      animalsLoaded: _animalsLoaded));

  void _validateAndSaveAll() {
    // Do not short-circuit the validation calls using &&
    final isFormValid = widget._innerFormKey.currentState.validate();
    final isInnerFormValid = _animalsLoadedFormField.validate();
    if (isFormValid && isInnerFormValid) widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._innerFormKey,
      child: Column(children: [
        ListTile(
            title: Text("Date and time of loading"),
            subtitle: dateTimePicker(
                initialDate: _dateAndTimeLoaded,
                onSaved: (String changed) {
                  _dateAndTimeLoaded = DateTime.parse(changed);
                  _saveAll();
                })),
        IntFormField(
            initial: _loadingArea,
            title: "Floor or container area available to animals (m2 or ft2)",
            onSaved: (int changed) {
              _loadingArea = changed;
              _saveNestedForms();
              _saveAll();
            }),
        IntFormField(
            initial: _loadingDensity,
            title: "Loading density",
            onSaved: (int changed) {
              _loadingDensity = changed;
              _saveAll();
            }),
        IntFormField(
            initial: _animalsPerLoadingArea,
            title: "Animals per floor area (Kg/m2 or lbs/ft2)",
            onSaved: (int changed) {
              _animalsPerLoadingArea = changed;
              _saveAll();
            }),
        ListTile(title: Text("Animals loaded")),
        _animalsLoadedFormField,
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
