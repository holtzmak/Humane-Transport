import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/test/test_address_expectations.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/form_field/fwr_event_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(FeedWaterRestEvent infoExpected) {
    // DropDownButtonFormFields have the values offscreen, so both are present
    expect(find.text(infoExpected.animalsWereUnloaded ? "Yes" : "No"),
        findsNWidgets(2));
    expect(find.text(infoExpected.fwrProvidedOnboard ? "Yes" : "No"),
        findsNWidgets(2));

    // Date and time are in separate fields
    expect(find.text(DateFormat('MMM d, yyyy').format(infoExpected.fwrTime)),
        findsOneWidget);
    expect(find.text(DateFormat('HH:mm').format(infoExpected.fwrTime)),
        findsOneWidget);

    verifyAddressIsShown(infoExpected.lastFwrLocation);
  }

  Future<void> pumpFwrEventFormField(
          WidgetTester tester,
          FeedWaterRestEvent initial,
          Function(FeedWaterRestEvent) onSaved,
          Function() onDelete) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: FeedWaterRestEventFormField(
        initial: initial,
        onSaved: onSaved,
        onDelete: onDelete,
      ))));

  group('Feed, Water, and Rest Event Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final feedWaterRestEvent = FeedWaterRestEvent(
          animalsWereUnloaded: true,
          fwrTime: DateTime.parse("2022-05-12 18:22"),
          lastFwrLocation: Address(
              streetAddress: "FWR location",
              city: "FWR city",
              provinceOrState: "FWR province",
              country: "FWR country",
              postalCode: "234rty"),
          fwrProvidedOnboard: false);
      await pumpFwrEventFormField(tester, feedWaterRestEvent, (_) {
        // do nothing for test
      }, () {
        // do nothing for test
      });
      verifyInformationIsShown(feedWaterRestEvent);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      await pumpFwrEventFormField(tester, testFwrEvent(), (_) {
        // do nothing for test
      }, onDeleteCallback);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets('onSaved called when edited', (WidgetTester tester) async {
      final testStreet = "Test street";
      final editedStreet = "Edited street";
      FeedWaterRestEvent callback;
      final onSavedCallback =
          (FeedWaterRestEvent changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testStreet);
      final editedFieldFinder =
          find.widgetWithText(TextFormField, editedStreet);
      final testFeedWaterRestEvent =
          testFwrEvent(lastFwrLocation: testAddress(streetAddress: testStreet));
      final editedFeedWaterRestEvent = testFwrEvent(
          lastFwrLocation: testAddress(streetAddress: editedStreet));

      await pumpFwrEventFormField(
          tester, testFeedWaterRestEvent, onSavedCallback, () {
        // do nothing for test
      });
      await tester.enterText(fieldFinder, editedStreet);
      await tester.pumpAndSettle();
      // expect was saved
      expect(callback, editedFeedWaterRestEvent);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
