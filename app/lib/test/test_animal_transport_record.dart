import 'dart:io';

import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/address.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

// Test tools intended to be used for convenience.

testAddress() => Address(
    streetAddress: "123 Anywhere St.",
    city: "Somewhere",
    provinceOrState: "Someplace",
    country: "Somehow",
    postalCode: "ABC123");

// If you want to specify any info use AnimalTransportRecord.with()
testAnimalTransportRecord(
        {ShipperInfo shipInfo,
        TransporterInfo tranInfo,
        FeedWaterRestInfo fwrInfo,
        LoadingVehicleInfo vehicleInfo,
        DeliveryInfo deliveryInfo,
        AcknowledgementInfo ackInfo,
        ContingencyPlanInfo contingencyInfo}) =>
    AnimalTransportRecord(
        shipInfo: shipInfo ?? testShipperInfo(),
        tranInfo: tranInfo ?? testTransporterInfo(),
        fwrInfo: fwrInfo ?? testFwrInfo(),
        vehicleInfo: vehicleInfo ?? testVehicleInfo(),
        deliveryInfo: deliveryInfo ?? testDeliveryInfo(),
        ackInfo: ackInfo ?? testAckInfo(),
        contingencyInfo: contingencyInfo ?? testContingencyInfo());

testShipperInfo(
        {String shipperName,
        bool shipperIsAnimalOwner,
        String departureLocationId,
        String departureLocationName,
        Address departureAddress,
        String shipperContactInfo}) =>
    ShipperInfo(
        shipperName: shipperName ?? "Jane Doe",
        shipperIsAnimalOwner: shipperIsAnimalOwner ?? false,
        departureLocationId: departureLocationId ?? "ABC123",
        departureLocationName: departureLocationName ?? "Home",
        departureAddress: departureAddress ?? testAddress(),
        shipperContactInfo: shipperContactInfo ?? "ABC123");

testTransporterInfo(
        {String companyName,
        Address companyAddress,
        List<String> driverNames,
        String vehicleProvince,
        String vehicleLicensePlate,
        String trailerProvince,
        String trailerLicensePlate,
        DateTime dateLastCleaned,
        Address addressLastCleanedAt,
        bool driversAreBriefed,
        bool driversHaveTraining,
        String trainingType,
        DateTime trainingExpiryDate}) =>
    TransporterInfo(
        companyName: companyName ?? "Smith Company",
        companyAddress: companyAddress ?? testAddress(),
        driverNames: driverNames ?? ["John Smith"],
        vehicleProvince: vehicleProvince ?? "Someplace",
        vehicleLicensePlate: vehicleLicensePlate ?? "ABC123",
        trailerProvince: trailerProvince ?? "Someplace",
        trailerLicensePlate: trailerLicensePlate ?? "ABC123",
        dateLastCleaned: dateLastCleaned ?? DateTime.now(),
        addressLastCleanedAt: addressLastCleanedAt ?? testAddress(),
        driversAreBriefed: driversAreBriefed ?? true,
        driversHaveTraining: driversHaveTraining ?? true,
        trainingType: trainingType ?? "Basic",
        trainingExpiryDate: trainingExpiryDate ?? DateTime.now());

testFwrInfo(
        {DateTime lastFwrDate,
        Address lastFwrLocation,
        FeedWaterRestEvent fwrEvents}) =>
    FeedWaterRestInfo(
        lastFwrDate: lastFwrDate ?? DateTime.now(),
        lastFwrLocation: lastFwrLocation ?? testAddress(),
        fwrEvents: fwrEvents ?? [testFwrEvent()]);

testFwrEvent(
        {bool animalsWereUnloaded,
        DateTime fwrTime,
        Address lastFwrLocation,
        bool fwrProvidedOnboard}) =>
    FeedWaterRestEvent(
        animalsWereUnloaded: animalsWereUnloaded ?? true,
        fwrTime: fwrTime ?? DateTime.now(),
        lastFwrLocation: lastFwrLocation ?? testAddress(),
        fwrProvidedOnboard: fwrProvidedOnboard ?? false);

testVehicleInfo(
        {DateTime dateAndTimeLoaded,
        int loadingArea,
        int loadingDensity,
        int animalsPerLoadingArea,
        List<AnimalGroup> animalsLoaded}) =>
    LoadingVehicleInfo(
        dateAndTimeLoaded: dateAndTimeLoaded ?? DateTime.now(),
        loadingArea: loadingArea ?? 1,
        loadingDensity: loadingDensity ?? 1,
        animalsPerLoadingArea: animalsPerLoadingArea ?? 1,
        animalsLoaded: animalsLoaded ?? [testAnimalGroup()]);

testAnimalGroup(
        {String species,
        int groupAge,
        int approximateWeight,
        String animalPurpose,
        int numberAnimals,
        bool animalsFitForTransport,
        List<CompromisedAnimal> compromisedAnimals,
        List<CompromisedAnimal> specialNeedsAnimals}) =>
    AnimalGroup(
        species: species ?? "Chicken",
        groupAge: groupAge ?? 1,
        approximateWeight: approximateWeight ?? 1,
        animalPurpose: animalPurpose ?? "Food",
        numberAnimals: numberAnimals ?? 1,
        animalsFitForTransport: animalsFitForTransport ?? true,
        compromisedAnimals: compromisedAnimals ?? List.empty(),
        specialNeedsAnimals: specialNeedsAnimals ?? List.empty());

testCompromisedAnimal(
        {String animalDescription, String measuresTakenToCareForAnimal}) =>
    CompromisedAnimal(
        animalDescription: animalDescription ?? "Injured leg",
        measuresTakenToCareForAnimal:
            measuresTakenToCareForAnimal ?? "Wrapped in available bandages");

testDeliveryInfo(
        {ReceiverInfo recInfo,
        DateTime arrivalDate,
        List<CompromisedAnimal> compromisedAnimals,
        String additionalWelfareConcerns}) =>
    DeliveryInfo(
        recInfo: recInfo ?? testReceiverInfo(),
        arrivalDateAndTime: arrivalDate ?? DateTime.now(),
        compromisedAnimals: compromisedAnimals ?? List.empty(),
        additionalWelfareConcerns: additionalWelfareConcerns ?? "None");

testReceiverInfo(
        {String receiverCompanyName,
        String receiverName,
        Optional<String> accountId,
        String destinationLocationId,
        String destinationLocationName,
        Address destinationAddress,
        String receiverContactInfo}) =>
    ReceiverInfo(
        receiverCompanyName: receiverCompanyName ?? "Doe Company",
        receiverName: receiverName ?? "Jane Doe",
        accountId: accountId ?? Optional.empty(),
        destinationLocationId: destinationLocationId ?? "ABC123",
        destinationLocationName: destinationLocationName ?? "Doe Company",
        destinationAddress: destinationAddress ?? testAddress(),
        receiverContactInfo: receiverContactInfo ?? "ABC123");

// TODO: Add mock files or something, we're not likely to use this
testAckInfo({File shipperAck, File transporterAck, File receiverAck}) =>
    AcknowledgementInfo(
        shipperAck: null, transporterAck: null, receiverAck: null);

testContingencyInfo(
        {String goalStatement,
        String communicationPlan,
        List<String> crisisContacts,
        String expectedPrepProcess,
        String standardAnimalMonitoring,
        List<String> potentialHazards,
        List<String> potentialSafetyActions,
        List<ContingencyPlanEvent> contingencyEvents}) =>
    ContingencyPlanInfo(
        goalStatement: goalStatement ?? "Humane transport",
        communicationPlan: communicationPlan ?? "Ask for help",
        crisisContacts: crisisContacts ?? ["Jane Doe"],
        expectedPrepProcess: expectedPrepProcess ?? "Ask for help",
        standardAnimalMonitoring: standardAnimalMonitoring ?? "Every hour",
        potentialHazards: potentialHazards ?? ["Car accident"],
        potentialSafetyActions: potentialSafetyActions ?? ["Use rest stops"],
        contingencyEvents: contingencyEvents ?? List.empty());

testContingencyEvent(
        {DateTime eventDateAndTime,
        List<String> producerContactsUsed,
        List<String> receiverContactsUsed,
        String disturbancesIdentified,
        List<ContingencyActivity> activities,
        List<String> actionsTaken}) =>
    ContingencyPlanEvent(
        eventDateAndTime: eventDateAndTime ?? DateTime.now(),
        producerContactsUsed: producerContactsUsed ?? ["John Smith"],
        receiverContactsUsed: receiverContactsUsed ?? ["Jane Doe"],
        disturbancesIdentified:
            disturbancesIdentified ?? "Animal found injured",
        activities: activities ?? [testContingencyActivity()],
        actionsTaken: actionsTaken ?? ["Wrapped in available bandages"]);

testContingencyActivity(
        {TimeOfDay time,
        String personContacted,
        String methodOfContact,
        String instructionsGiven}) =>
    ContingencyActivity(
        time: time ?? TimeOfDay.now(),
        personContacted: personContacted ?? "Receiver",
        methodOfContact: methodOfContact ?? "Phone call",
        instructionsGiven: instructionsGiven ?? "Instructions");
