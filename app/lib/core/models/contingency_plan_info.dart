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

  String _contingencyEventsToString() => _contingencyEvents.isEmpty
      ? 'No events occurred during transport'
      : _contingencyEvents.map((event) => event.toString()).toList().join(",");

  String toString() =>
      '''Goal Statement (company’s goal and purpose of the plan i.e avoid animal suffering): $goalStatement
  Communication Plan (who should be contacted and who will initiate or permit the process?): $communicationPlan
  Crisis contacts and links( general helpline, industry related links and websites): ${_crisisContacts.join(',')}
  Expected Preparation Process (what should be done prior to loading animals?): $expectedPrepProcess
  Standard Animal Monitoring: $standardAnimalMonitoring
  Potential Hazard/Events/Challenges: ${_potentialHazards.join(',')}
  Potential Actions to Ensure Human or Animal Safety: ${_potentialSafetyActions.join(',')}
  Event Specific Plan(s): ${_contingencyEventsToString()}''';
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

  String toString() =>
      '''Date and time of event: ${DateFormat("yyyy-MM-dd hh:mm").format(eventDateAndTime)}
  Producer's emergency contacts used: ${_producerContactsUsed.join(",")}
  Receiver's emergency contacts used: ${_receiverContactsUsed.join(",")}
  Transportation challenges and disturbances identified by driver: $disturbancesIdentified
  List of animal welfare related measures and actions taken(specific to the event): ${_actionsTaken.join(",")}
  Carrier's communication activities:
  ${_activities.map((activity) => activity.toString()).toList().join(',')}''';
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

  String toString() => '''Time of communication: $time
  Who was contacted: $personContacted
  Communication method used: $methodOfContact
  What instructions were given and decisions made with the guidance of emergency contacts reached: $instructionsGiven''';
}
