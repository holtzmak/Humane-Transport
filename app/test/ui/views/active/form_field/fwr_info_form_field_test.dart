import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/test/helper/test_address_expectations.dart';
import 'package:app/test/helper/test_fwr_event_expectations.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/fwr_info_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  void verifyInformationIsShown(FeedWaterRestInfo infoExpected) {
    infoExpected.fwrEvents.forEach((event) {
      verifyFwrEventInformationIsShown(event);
    });
    verifyAddressIsShown(infoExpected.lastFwrLocation);
    // Date and time are in separate fields
    expect(
        find.text(DateFormat('MMM d, yyyy').format(infoExpected.lastFwrDate)),
        findsOneWidget);
    expect(find.text(DateFormat('HH:mm').format(infoExpected.lastFwrDate)),
        findsOneWidget);
  }

  Future<void> pumpFwrInfoFormField(
          WidgetTester tester,
          FeedWaterRestInfo testInfo,
          Function(FeedWaterRestInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: FeedWaterRestInfoFormField(
            initialInfo: testInfo, onSaved: callback),
      )))));

  group('Feed, Water, and Rest Info Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final testFwrInfo = FeedWaterRestInfo(
        lastFwrDate: DateTime.parse("2021-02-03 13:01"),
        lastFwrLocation: Address(
            streetAddress: "456 St.",
            city: "Calgary",
            provinceOrState: "Alberta",
            country: "Canada",
            postalCode: "4h5yu6"),
        fwrEvents: [
          FeedWaterRestEvent(
              animalsWereUnloaded: true,
              fwrTime: DateTime.parse("2021-05-12 18:22"),
              lastFwrLocation: Address(
                  streetAddress: "FWR location 1",
                  city: "FWR city 1",
                  provinceOrState: "FWR province 1",
                  country: "FWR country 1",
                  postalCode: "234rty"),
              fwrProvidedOnboard: false),
          FeedWaterRestEvent(
              animalsWereUnloaded: true,
              fwrTime: DateTime.parse("2021-05-13 23:00"),
              lastFwrLocation: Address(
                  streetAddress: "FWR location 2",
                  city: "FWR city 2",
                  provinceOrState: "FWR province 2",
                  country: "FWR country 2",
                  postalCode: "456uio"),
              fwrProvidedOnboard: false)
        ],
      );
      await pumpFwrInfoFormField(tester, testFwrInfo, (_) {
        // Do nothing for test
      });
      verifyInformationIsShown(testFwrInfo);
    });

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpFwrInfoFormField(tester, testFwrInfo(), (_) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testFwrInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      FeedWaterRestInfo callbackInfo;
      final onSavedCallback = (FeedWaterRestInfo info) => callbackInfo = info;

      await pumpFwrInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets(
        'calls onSaved with edited address info when save button pressed',
        (WidgetTester tester) async {
      final initialStreet = "ABC Street";
      final editedStreet = "Edited Street";
      final testInfo = testFwrInfo(
          lastFwrLocation: testAddress(streetAddress: initialStreet));
      final editedInfo = testFwrInfo(
          lastFwrLocation: testAddress(streetAddress: editedStreet));

      FeedWaterRestInfo callback;
      final onSaved = (FeedWaterRestInfo changed) => callback = changed;

      final fieldFinder = find.text(initialStreet);
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");

      await pumpFwrInfoFormField(tester, testInfo, onSaved);
      // Edit text
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedStreet);
      await tester.pumpAndSettle();
      // Save
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });
  });
}
