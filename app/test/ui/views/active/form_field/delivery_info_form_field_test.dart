import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/test/helper/test_compromised_animal_expectations.dart';
import 'package:app/test/helper/test_receiver_info_expectations.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/delivery_info_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  void verifyInformationIsShown(DeliveryInfo infoExpected) {
    infoExpected.compromisedAnimals.forEach((animal) {
      verifyCompromisedAnimalInfoIsShown(animal);
    });
    // Date and time are in separate fields
    expect(
        find.text(
            DateFormat('MMM d, yyyy').format(infoExpected.arrivalDateAndTime)),
        findsOneWidget);
    expect(
        find.text(DateFormat('HH:mm').format(infoExpected.arrivalDateAndTime)),
        findsOneWidget);
    verifyReceiverInfoIsShown(infoExpected.recInfo);
    expect(find.text(infoExpected.additionalWelfareConcerns), findsOneWidget);
  }

  Future<void> pumpDeliveryInfoFormField(WidgetTester tester,
          DeliveryInfo testInfo, Function(DeliveryInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: DeliveryInfoFormField(initialInfo: testInfo, onSaved: callback),
      )))));

  group('Delivery Info Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final testDeliveryInfo = DeliveryInfo(
          recInfo: ReceiverInfo(
              receiverCompanyName: "Temp Company",
              receiverName: "John Caddy",
              accountId: Optional.of("789er"),
              destinationLocationId: "uioet483u9",
              destinationLocationName: "Farmville",
              destinationAddress: testAddress(),
              receiverContactInfo: "By email: test@gmail.com"),
          arrivalDateAndTime: DateTime.parse("2023-11-14 14:21"),
          compromisedAnimals: [],
          additionalWelfareConcerns: "None");
      await pumpDeliveryInfoFormField(tester, testDeliveryInfo, (_) {
        // Do nothing for test
      });
      verifyInformationIsShown(testDeliveryInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpDeliveryInfoFormField(tester, testDeliveryInfo(), (_) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testDeliveryInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      DeliveryInfo callbackInfo;
      final onSavedCallback = (DeliveryInfo info) => callbackInfo = info;

      await pumpDeliveryInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets(
        'calls onSaved with edited compromised animal info when save button pressed',
        (WidgetTester tester) async {
      final testDescription = "Chicken bad leg";
      final editedDescription = "Turkey bad leg";
      final testInfo = testDeliveryInfo(compromisedAnimals: [
        testCompromisedAnimal(animalDescription: testDescription)
      ]);
      final editedInfo = testDeliveryInfo(compromisedAnimals: [
        testCompromisedAnimal(animalDescription: editedDescription)
      ]);

      DeliveryInfo callback;
      final onSaved = (DeliveryInfo changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testDescription);
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");

      await pumpDeliveryInfoFormField(tester, testInfo, onSaved);
      // Edit text
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedDescription);
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });
  });
}
