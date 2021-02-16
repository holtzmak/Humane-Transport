import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class ContingencyPlanInfo {
  final String goalStatement;
  final String communicationPlan;
  final List<String> _crisisContacts;
  final String expectedPrepProcess;
  final String standardAnimalMonitoring;
  final List<String> _potentialHazards;
  final List<String> _potentialSafetyActions;
  final List<ContingencyPlanEvent> _contingencyEvents;

  ContingencyPlanInfo(
      {@required this.goalStatement,
      @required this.communicationPlan,
      @required List<String> crisisContacts,
      @required this.expectedPrepProcess,
      @required this.standardAnimalMonitoring,
      @required List<String> potentialHazards,
      @required List<String> potentialSafetyActions,
      @required List<ContingencyPlanEvent> contingencyEvents})
      : _crisisContacts = crisisContacts,
        _potentialHazards = potentialHazards,
        _potentialSafetyActions = potentialSafetyActions,
        _contingencyEvents = contingencyEvents;

  List<String> crisisContacts() => List.unmodifiable(_crisisContacts);

  List<String> potentialHazards() => List.unmodifiable(_potentialHazards);

  List<String> potentialSafetyActions() =>
      List.unmodifiable(_potentialSafetyActions);

  List<ContingencyPlanEvent> contingencyEvents() =>
      List.unmodifiable(_contingencyEvents);

  List<Widget> _contingencyEventsToWidget() => _contingencyEvents.isEmpty
      ? [
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              title: Text('No events occurred during transport'))
        ]
      : _contingencyEvents.map((event) => event.toWidget()).toList();

  Widget toWidget() {
    final List<Widget> fields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Goal Statement (company’s goal and purpose of the plan i.e avoid animal suffering)"),
          subtitle: Text(goalStatement)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Communication Plan (who should be contacted and who will initiate or permit the process?)"),
          subtitle: Text(communicationPlan)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Crisis contacts and links( general helpline, industry related links and websites)"),
          subtitle: Text('${_crisisContacts.join(',')}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Expected Preparation Process (what should be done prior to loading animals?)"),
          subtitle: Text(expectedPrepProcess)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Standard Animal Monitoring"),
          subtitle: Text(standardAnimalMonitoring)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Potential Hazard/Events/Challenges"),
          subtitle: Text('${_potentialHazards.join(',')}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Potential Actions to Ensure Human or Animal Safety"),
          subtitle: Text('${_potentialSafetyActions.join(',')}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Event Specific Plan(s)")),
    ];
    fields.addAll(_contingencyEventsToWidget());
    return Column(children: fields);
  }
}

@immutable
class ContingencyPlanEvent {
  final DateTime eventDateAndTime;
  final List<String> _producerContactsUsed;
  final List<String> _receiverContactsUsed;
  final String disturbancesIdentified;
  final List<ContingencyActivity> _activities;
  final List<String> _actionsTaken;

  ContingencyPlanEvent(
      {@required this.eventDateAndTime,
      @required List<String> producerContactsUsed,
      @required List<String> receiverContactsUsed,
      @required this.disturbancesIdentified,
      @required List<ContingencyActivity> activities,
      @required List<String> actionsTaken})
      : _producerContactsUsed = producerContactsUsed,
        _receiverContactsUsed = receiverContactsUsed,
        _activities = activities,
        _actionsTaken = actionsTaken;

  List<String> producerContactsUsed() =>
      List.unmodifiable(_producerContactsUsed);

  List<String> receiverContactsUsed() =>
      List.unmodifiable(_receiverContactsUsed);

  List<ContingencyActivity> activities() => List.unmodifiable(_activities);

  List<String> actionsTaken() => List.unmodifiable(_actionsTaken);

  Widget toWidget() {
    final List<Widget> widgetFields = [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Date and time of event"),
          subtitle: Text(
              '${DateFormat("yyyy-MM-dd hh:mm").format(eventDateAndTime)}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Producer's emergency contacts used"),
          subtitle: Text('${_producerContactsUsed.join(",")}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Receiver's emergency contacts used"),
          subtitle: Text('${_receiverContactsUsed.join(",")}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "Transportation challenges and disturbances identified by driver"),
          subtitle: Text(disturbancesIdentified)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "List of animal welfare related measures and actions taken(specific to the event)"),
          subtitle: Text('${_actionsTaken.join(",")}')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Carrier's communication activities")),
    ];
    widgetFields
        .addAll(_activities.map((activity) => activity.toWidget()).toList());
    return Column(children: widgetFields);
  }
}

@immutable
class ContingencyActivity {
  final TimeOfDay time;
  final String personContacted;
  final String methodOfContact;
  final String instructionsGiven;

  ContingencyActivity(
      {@required this.time,
      @required this.personContacted,
      @required this.methodOfContact,
      @required this.instructionsGiven});

  Widget toWidget() {
    return Column(children: [
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Time of communication"),
          subtitle: Text('$time')),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Who was contacted"),
          subtitle: Text(personContacted)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text("Communication method used"),
          subtitle: Text(methodOfContact)),
      ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          title: Text(
              "What instructions were given and decisions made with the guidance of emergency contacts reached"),
          subtitle: Text(instructionsGiven)),
    ]);
  }
}
