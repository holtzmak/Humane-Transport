import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/test/helper/test_fwr_event_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/fwr_event_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpFwrEventFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
        child: widget,
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
      final widget = FeedWaterRestEventFormField(
        initial: feedWaterRestEvent,
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: () {
          // do nothing for test
        },
      );
      await pumpFwrEventFormField(tester, widget);
      verifyFwrEventInformationIsShown(feedWaterRestEvent);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = FeedWaterRestEventFormField(
        initial: testFwrEvent(),
        onSaved: (_) {
          // do nothing for test
        },
        onDelete: onDeleteCallback,
      );
      await pumpFwrEventFormField(tester, widget);
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
      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: FeedWaterRestEventFormField(
            initial: testFeedWaterRestEvent,
            onSaved: onSavedCallback,
            onDelete: () {
              // do nothing for test
            },
          ));
      await pumpFwrEventFormField(tester, widget);
      await tester.enterText(fieldFinder, editedStreet);
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedFeedWaterRestEvent);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
