import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> testTransporterJson() => {
      'firstName': 'clark',
      'lastName': 'sasa',
      'userEmailAddress': 'sasasass',
      'userPhoneNumber': '121212',
      'userId': 'this Is user id',
      'isAdmin': false
    };

Map<String, dynamic> testAtrIdentifierJson() => {
      "userId": "23512",
      "isComplete": false,
    };

Map<String, dynamic> testAtrJson() => {
      "shipperInfo": {
        "shipperName": "Clark",
        "shipperIsAnimalOwner": false,
        "departureLocationId": "123",
        "departureLocationName": "SomePlace",
        "shipperContactInfo": "213",
        "departureAddress": {
          "streetAddress": "Bruce",
          "city": "Regina",
          "provinceOrState": "some state",
          "postalCode": "dfsdf",
          "country": "Canada"
        }
      },
      "transportInfo": {
        "companyName": "Company A",
        "companyAddress": {
          "streetAddress": "Bruce",
          "city": "Regina",
          "provinceOrState": "some state",
          "postalCode": "dfsdf",
          "country": "Canada"
        },
        "driverNames": ["Name 1", "Name 2"],
        "vehicleProvince": "vehicleProvince Name",
        "vehicleLicensePlate": "vehicleLicensePlate plate",
        "trailerProvince": "trailerProvince province",
        "trailerLicensePlate": "trailerLicensePlate plate",
        "dateLastCleaned": Timestamp.fromDate(
            (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
        "addressLastCleanedAt": {
          "streetAddress": "Bruce",
          "city": "Regina",
          "provinceOrState": "some state",
          "postalCode": "dfsdf",
          "country": "Canada"
        },
        "driversAreBriefed": false,
        "driversHaveTraining": false,
        "trainingType": "trainingType type",
        "trainingExpiryDate": Timestamp.fromDate(
            (DateTime.parse("2020-01-29T18:39:51.396781283+01:00")))
      },
      "feedWaterRestInfo": {
        "lastFeedWaterRestDate": Timestamp.fromDate(
            (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
        "lastFeedWaterRestLocation": {
          "streetAddress": "Bruce",
          "city": "Regina",
          "provinceOrState": "some state",
          "postalCode": "dfsdf",
          "country": "Canada"
        },
        "feedWaterRestEvents": [
          {
            "animalsWereUnloaded": false,
            "feedWaterRestTime": Timestamp.fromDate(
                (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
            "lastFeedWaterRestLocation": {
              "streetAddress": "Bruce",
              "city": "Regina",
              "provinceOrState": "some state",
              "postalCode": "dfsdf",
              "country": "Canada"
            },
            "feedWaterRestProvidedOnboard": false
          }
        ]
      },
      "loadingVehicleInfo": {
        "dateAndTimeLoaded": Timestamp.fromDate(
            (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
        "loadingArea": 1,
        "loadingDensity": 2,
        "animalsPerLoadingArea": 3,
        "animalsLoaded": [
          {
            "species": "species A",
            "groupAge": 1,
            "approximateWeight": 2,
            "animalPurpose": "hello",
            "numberAnimals": 2,
            "animalsFitForTransport": false,
            "compromisedAnimals": [
              {
                "animalDescription": "animalDescription",
                "measuresTakenToCareForAnimal": "measuresTakenToCareForAnimal"
              }
            ],
            "specialNeedsAnimals": [
              {
                "animalDescription": "animalDescription",
                "measuresTakenToCareForAnimal": "measuresTakenToCareForAnimal"
              }
            ]
          }
        ]
      },
      "deliveryInfo": {
        "receiverInfo": {
          "receiverCompanyName": "receiverCompanyName a",
          "receiverName": "receiverName A",
          "accountId": null,
          "destinationLocationId": "destinationLocationId a",
          "destinationLocationName": "destinationLocationName a",
          "destinationAddress": {
            "streetAddress": "Bruce",
            "city": "Regina",
            "provinceOrState": "some state",
            "postalCode": "dfsdf",
            "country": "Canada"
          },
          "receiverContactInfo": "receiverContactInfo"
        },
        "arrivalDateAndTime": Timestamp.fromDate(
            (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
        "compromisedAnimals": [
          {
            "animalDescription": "animalDescription",
            "measuresTakenToCareForAnimal": "measuresTakenToCareForAnimal"
          }
        ],
        "additionalWelfareConcerns": "additionalWelfareConcerns"
      },
      "acknowledgementInfo": {
        "shipperAck": null,
        "transporterAck": null,
        "receiverAck": null
      },
      "contingencyPlanInfo": {
        "goalStatement": "goalStatement",
        "communicationPlan": "communicationPlan",
        "crisisContacts": ["a", "b"],
        "expectedPrepProcess": "expectedPrepProcess",
        "standardAnimalMonitoring": "standardAnimalMonitoring",
        "potentialHazards": ["a", "b"],
        "potentialSafetyActions": ["a", "b"],
        "contingencyEvents": [
          {
            "eventDateAndTime": Timestamp.fromDate(
                (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
            "producerContactsUsed": ["a", "b"],
            "receiverContactsUsed": ["a", "b"],
            "disturbancesIdentified": "disturbancesIdentified",
            "activities": [
              {
                "time": Timestamp.fromDate(
                    (DateTime.parse("2020-01-29T18:39:51.396781283+01:00"))),
                "personContacted": "personContacted",
                "methodOfContact": "methodOfContact",
                "instructionsGiven": "instructionsGiven"
              }
            ],
            "actionsTaken": ["a", "b"]
          }
        ]
      },
      "identifier": {
        "userId": "23512",
        "isComplete": false,
      },
    };
