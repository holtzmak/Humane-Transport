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
      this.goalStatement,
      this.communicationPlan,
      this._crisisContacts,
      this.expectedPrepProcess,
      this.standardAnimalMonitoring,
      this._potentialHazards,
      this._potentialSafetyActions,
      this._contingencyEvents);

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
      this.eventDate,
      this.eventTime,
      this._producerContactsUsed,
      this._receiverContactsUsed,
      this.disturbancesIdentified,
      this._activities,
      this._actionsTaken);

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

  ContingencyActivity(this.time, this.personContacted, this.methodOfContact,
      this.instructionsGiven);
}
