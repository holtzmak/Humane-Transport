Map<String, dynamic> fakeData() {
  Map<String, dynamic> _fakeResponse = {
    'firstName': 'clark',
    'lastName': 'sasa',
    'userEmailAddress': 'sasasass',
    'userPhoneNumber': '121212',
    'userId': 'this Is user id',
    'isAdmin': false
  };
  return _fakeResponse;
}

Map<String, dynamic> fakeATR() {
  Map<String, dynamic> _fakeATRResponse = {
    "userId": "23512",
    "isComplete": false,
    "shipInfo": {
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
    "tranInfo": {
      "companyName": "Company A",
      "companyAddress": {
        "streetAddress": "Bruce",
        "city": "Regina",
        "provinceOrState": "some state",
        "postalCode": "dfsdf",
        "country": "Canada"
      },
      "_driverNames": ["Name 1", "Name 2"],
      "vehicleProvince": "vehicleProvince Name",
      "vehicleLicensePlate": "vehicleLicensePlate plate",
      "trailerProvince": "trailerProvince province",
      "trailerLicensePlate": "trailerLicensePlate plate",
      "dateLastCleaned": "2020-01-29T18:39:51.396781283+01:00",
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
      "trainingExpiryDate": "2020-01-29T18:39:51.396781283+01:00"
    },
    "fwrInfo": {
      "lastFwrDate": "2020-01-29T18:39:51.396781283+01:00",
      "lastFwrLocation": {
        "streetAddress": "Bruce",
        "city": "Regina",
        "provinceOrState": "some state",
        "postalCode": "dfsdf",
        "country": "Canada"
      },
      "_fwrEvents": [
        {
          "animalsWereUnloaded": false,
          "fwrTime": "2020-01-29T18:39:51.396781283+01:00",
          "lastFwrLocation": {
            "streetAddress": "Bruce",
            "city": "Regina",
            "provinceOrState": "some state",
            "postalCode": "dfsdf",
            "country": "Canada"
          },
          "fwrProvidedOnboard": false
        }
      ]
    },
    "vehicleInfo": {
      "dateAndTimeLoaded": "2020-01-29T18:39:51.396781283+01:00",
      "loadingArea": 1,
      "loadingDensity": 2,
      "animalsPerLoadingArea": 3,
      "_animalsLoaded": [
        {
          "species": "species A",
          "groupAge": 1,
          "approximateWeight": 2,
          "animalPurpose": "hello",
          "numberAnimals": 2,
          "animalsFitForTransport": false,
          "_compromisedAnimals": [
            {
              "animalDescription": "animalDescription",
              "measuresTakenToCareForAnimal": "measuresTakenToCareForAnimal"
            }
          ],
          "_specialNeedsAnimals": [
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
      "arrivalDateAndTime": "2020-01-29T18:39:51.396781283+01:00",
      "_compromisedAnimals": [
        {
          "animalDescription": "animalDescription",
          "measuresTakenToCareForAnimal": "measuresTakenToCareForAnimal"
        }
      ],
      "additionalWelfareConcerns": "additionalWelfareConcerns"
    },
    "ackInfo": {
      "shipperAck": "file",
      "transporterAck": "file",
      "receiverAck": "file"
    },
    "contingencyInfo": {
      "goalStatement": "goalStatement",
      "communicationPlan": "communicationPlan",
      "_crisisContacts": ["a", "b"],
      "expectedPrepProcess": "expectedPrepProcess",
      "standardAnimalMonitoring": "standardAnimalMonitoring",
      "_potentialHazards": ["a", "b"],
      "_potentialSafetyActions": ["a", "b"],
      "_contingencyEvents": [
        {
          "eventDateAndTime": "2020-01-29T18:39:51.396781283+01:00",
          "_producerContactsUsed": ["a", "b"],
          "_receiverContactsUsed": ["a", "b"],
          "disturbancesIdentified": "disturbancesIdentified",
          "_activities": [
            {
              "time": "2020-01-29T18:39:51.396781283+01:00",
              "personContacted": "personContacted",
              "methodOfContact": "methodOfContact",
              "instructionsGiven": "instructionsGiven"
            }
          ],
          "_actionsTaken": ["a", "b"]
        }
      ]
    }
  };
  return _fakeATRResponse;
}
