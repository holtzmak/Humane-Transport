import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_contingency_plan_event_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';

class ContingencyPlanInfoFormField extends StatefulWidget {
  final Function(ContingencyPlanInfo info) onSaved;
  final ContingencyPlanInfo initialInfo;
  final String title = "Contingency Plan";
  final _innerFormKey = GlobalKey<FormState>();

  void save() => _innerFormKey.currentState.save();

  // This function does not change the state of the widget
  // Must call validate within widget for error text to appear
  bool validate() => _innerFormKey.currentState.validate();

  ContingencyPlanInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _ContingencyPlanInfoFormFieldState createState() =>
      _ContingencyPlanInfoFormFieldState();
}

class _ContingencyPlanInfoFormFieldState
    extends State<ContingencyPlanInfoFormField> {
  String _goalStatement;
  String _communicationPlan;
  List<String> _crisisContacts;
  String _expectedPrepProcess;
  String _standardAnimalMonitoring;
  List<String> _potentialHazards;
  List<String> _potentialSafetyActions;
  List<ContingencyPlanEvent> _contingencyEvents;

  DynamicFormField<String> _crisisContactsFormField;
  DynamicFormField<String> _potentialHazardsFormField;
  DynamicFormField<String> _potentialSafetyActionsFormField;
  DynamicFormField<ContingencyPlanEvent> _contingencyEventsFormField;

  @override
  void initState() {
    _goalStatement = widget.initialInfo.goalStatement;
    _communicationPlan = widget.initialInfo.communicationPlan;
    _crisisContacts = widget.initialInfo.crisisContacts;
    _expectedPrepProcess = widget.initialInfo.expectedPrepProcess;
    _standardAnimalMonitoring = widget.initialInfo.standardAnimalMonitoring;
    _potentialHazards = widget.initialInfo.potentialHazards;
    _potentialSafetyActions = widget.initialInfo.potentialSafetyActions;
    _contingencyEvents = widget.initialInfo.contingencyEvents;

    _crisisContactsFormField = dynamicStringFormField(
        initialList: _crisisContacts,
        onSaved: (List<String> changed) {
          _crisisContacts = changed;
          _saveAll();
        },
        titles: "Producer contact used");
    _potentialHazardsFormField = dynamicStringFormField(
        initialList: _potentialHazards,
        onSaved: (List<String> changed) {
          _potentialHazards = changed;
          _saveAll();
        },
        titles: "Receiver contact used");
    _potentialSafetyActionsFormField = dynamicStringFormField(
        initialList: _potentialSafetyActions,
        onSaved: (List<String> changed) {
          _potentialSafetyActions = changed;
          _saveAll();
        },
        titles: "Action taken");
    _contingencyEventsFormField = dynamicContingencyPlanEventFormField(
        initialList: _contingencyEvents,
        onSaved: (List<ContingencyPlanEvent> changed) {
          _contingencyEvents = changed;
          _saveAll();
        });
    super.initState();
  }

  // As the forms are nested, they need to be told to save
  // Only one call to saved them is needed as this form's fields are saved together
  void _saveNestedForms() {
    _crisisContactsFormField.save();
    _potentialHazardsFormField.save();
    _potentialSafetyActionsFormField.save();
    _contingencyEventsFormField.save();
  }

  void _saveAll() => widget.onSaved(ContingencyPlanInfo(
      goalStatement: _goalStatement,
      communicationPlan: _communicationPlan,
      crisisContacts: _crisisContacts,
      expectedPrepProcess: _expectedPrepProcess,
      standardAnimalMonitoring: _standardAnimalMonitoring,
      potentialHazards: _potentialHazards,
      potentialSafetyActions: _potentialSafetyActions,
      contingencyEvents: _contingencyEvents));

  void _validateAndSaveAll() {
    // Do not short-circuit the validation calls using &&
    final isFormValid = widget._innerFormKey.currentState.validate();
    final areCrisisContactsValid = _crisisContactsFormField.validate();
    final areContingencyPlanEventsValid =
        _contingencyEventsFormField.validate();
    final arePotentialHazardsValid = _potentialHazardsFormField.validate();
    final areSafetyActionsValid = _potentialSafetyActionsFormField.validate();
    if (isFormValid &&
        areCrisisContactsValid &&
        areContingencyPlanEventsValid &&
        arePotentialHazardsValid &&
        areSafetyActionsValid) {
      widget.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._innerFormKey,
      child: Column(children: [
        StringFormField(
            initial: _goalStatement,
            isMultiline: true,
            title:
                "Goal Statement (company’s goal and purpose of the plan i.e avoid animal suffering)",
            onSaved: (String changed) {
              _goalStatement = changed;
              _saveNestedForms();
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _communicationPlan,
            isMultiline: true,
            title:
                "Communication Plan (who should be contacted and who will initiate or permit the process?)",
            onSaved: (String changed) {
              _communicationPlan = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
          title: Text(
              "Crisis contacts and links (general helpline, industry related links and websites)"),
        ),
        _crisisContactsFormField,
        StringFormField(
            initial: _expectedPrepProcess,
            isMultiline: true,
            title:
                "Expected Preparation Process (what should be done prior to loading animals?)",
            onSaved: (String changed) {
              _expectedPrepProcess = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        StringFormField(
            initial: _standardAnimalMonitoring,
            isMultiline: true,
            title: "Standard Animal Monitoring",
            onSaved: (String changed) {
              _standardAnimalMonitoring = changed;
              _saveAll();
            },
            onDelete: Optional.empty()),
        ListTile(
          title: Text("Potential Hazard/Events/Challenges"),
        ),
        _potentialHazardsFormField,
        ListTile(
          title: Text("Potential Actions to Ensure Human or Animal Safety"),
        ),
        _potentialSafetyActionsFormField,
        ListTile(
          title: Text("Event Specific Plan(s)"),
        ),
        _contingencyEventsFormField,
        RaisedButton(child: Text("Save"), onPressed: _validateAndSaveAll)
      ]),
    );
  }
}
