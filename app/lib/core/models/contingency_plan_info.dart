import 'package:flutter/material.dart';

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
      {@required String goalStatement,
      @required String communicationPlan,
      @required List<String> crisisContacts,
      @required String expectedPrepProcess,
      @required String standardAnimalMonitoring,
      @required List<String> potentialHazards,
      @required List<String> potentialSafetyActions,
      @required List<ContingencyPlanEvent> contingencyEvents})
      : goalStatement = goalStatement,
        communicationPlan = communicationPlan,
        _crisisContacts = crisisContacts,
        expectedPrepProcess = expectedPrepProcess,
        standardAnimalMonitoring = standardAnimalMonitoring,
        _potentialHazards = potentialHazards,
        _potentialSafetyActions = potentialSafetyActions,
        _contingencyEvents = contingencyEvents;

  List<String> crisisContacts() => List.unmodifiable(_crisisContacts);

  List<String> potentialHazards() => List.unmodifiable(_potentialHazards);

  List<String> potentialSafetyActions() =>
      List.unmodifiable(_potentialSafetyActions);

  List<ContingencyPlanEvent> contingencyEvents() =>
      List.unmodifiable(_contingencyEvents);
}

@immutable
class ContingencyPlanEvent {
  final DateTime eventDate;
  final TimeOfDay eventTime;
  final List<String> _producerContactsUsed;
  final List<String> _receiverContactsUsed;
  final String disturbancesIdentified;
  final List<ContingencyActivity> _activities;
  final List<String> _actionsTaken;

  ContingencyPlanEvent(
      {@required DateTime eventDate,
      @required TimeOfDay eventTime,
      @required List<String> producerContactsUsed,
      @required List<String> receiverContactsUsed,
      @required String disturbancesIdentified,
      @required List<ContingencyActivity> activities,
      @required List<String> actionsTaken})
      : eventDate = eventDate,
        eventTime = eventTime,
        _producerContactsUsed = producerContactsUsed,
        _receiverContactsUsed = receiverContactsUsed,
        disturbancesIdentified = disturbancesIdentified,
        _activities = activities,
        _actionsTaken = actionsTaken;

  List<String> producerContactsUsed() =>
      List.unmodifiable(_producerContactsUsed);

  List<String> receiverContactsUsed() =>
      List.unmodifiable(_receiverContactsUsed);

  List<ContingencyActivity> activities() => List.unmodifiable(_activities);

  List<String> actionsTaken() => List.unmodifiable(_actionsTaken);
}

@immutable
class ContingencyActivity {
  final TimeOfDay time;
  final String personContacted;
  final String methodOfContact;
  final String instructionsGiven;

  ContingencyActivity(
      {@required TimeOfDay time,
      @required String personContacted,
      @required String methodOfContact,
      @required String instructionsGiven})
      : time = time,
        personContacted = personContacted,
        methodOfContact = methodOfContact,
        instructionsGiven = instructionsGiven;
}
