import 'package:app/core/models/address.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/test/test_fwr_event_expectations.dart';
import 'package:app/ui/views/active/form_field/dynamic_fwr_event_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyNoDuplicateInfoShown(List<FeedWaterRestEvent> infoExpected) {
    infoExpected.forEach((event) => verifyFwrEventInformationIsShown(event));
  }

  void verifyOneEmptyFwrEventShown(FeedWaterRestEvent info) {
    // Date and time are in separate fields
    expect(find.text(DateFormat('MMM d, yyyy').format(info.fwrTime)),
        findsOneWidget);
    expect(find.text(DateFormat('HH:mm').format(info.fwrTime)), findsOneWidget);

    // There are 5 fields to the event that should have no initial information
    expect(find.text(""), findsNWidgets(5));
  }

  void verifyInfoNotShown(FeedWaterRestEvent info) {
    // Date and time are in separate fields
    expect(find.text(DateFormat('MMM d, yyyy').format(info.fwrTime)),
        findsNothing);
    expect(find.text(DateFormat('HH:mm').format(info.fwrTime)), findsNothing);

    expect(find.text(info.lastFwrLocation.streetAddress), findsNothing);
    expect(find.text(info.lastFwrLocation.city), findsNothing);
    expect(find.text(info.lastFwrLocation.provinceOrState), findsNothing);
    expect(find.text(info.lastFwrLocation.country), findsNothing);
    expect(find.text(info.lastFwrLocation.postalCode), findsNothing);
  }

  Future<void> pumpDynamicFwrFormField(
          WidgetTester tester,
          List<FeedWaterRestEvent> initialList,
          Function(List<FeedWaterRestEvent>) onSaved) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: SingleChildScrollView(
          child: DynamicFWREventFormField(
            initialList: initialList,
            onSaved: onSaved,
          ),
        ),
      )));

  group('Dynamic FWR Form Field', () {
    testWidgets('shows right information for multiple events',
        (WidgetTester tester) async {
      final testItems = [
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
            fwrProvidedOnboard: false),
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-14 04:20"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 3",
                city: "FWR city 3",
                provinceOrState: "FWR province 3",
                country: "FWR country 3",
                postalCode: "789hjk"),
            fwrProvidedOnboard: false)
      ];
      await pumpDynamicFwrFormField(tester, testItems, (_) {
        // do nothing for test
      });
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testItems);
    });

    testWidgets('shows no information when no fields',
        (WidgetTester tester) async {
      await pumpDynamicFwrFormField(tester, <FeedWaterRestEvent>[], (_) {
        // do nothing for test
      });
      expect(find.text("No events, try adding some!"), findsOneWidget);
    });

    testWidgets('delete button pressed removes field',
        (WidgetTester tester) async {
      final firstItemDeleteButtonFinder = find.byIcon(Icons.delete).first;
      final itemToDelete = FeedWaterRestEvent(
          animalsWereUnloaded: true,
          fwrTime: DateTime.parse("2021-05-12 23:00"),
          lastFwrLocation: Address(
              streetAddress: "FWR location 2",
              city: "FWR city 2",
              provinceOrState: "FWR province 2",
              country: "FWR country 2",
              postalCode: "456uio"),
          fwrProvidedOnboard: false);
      final testItems = [
        itemToDelete,
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-13 18:22"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 1",
                city: "FWR city 1",
                provinceOrState: "FWR province 1",
                country: "FWR country 1",
                postalCode: "234rty"),
            fwrProvidedOnboard: false),
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-14 04:20"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 3",
                city: "FWR city 3",
                provinceOrState: "FWR province 3",
                country: "FWR country 3",
                postalCode: "789hjk"),
            fwrProvidedOnboard: false)
      ];
      await pumpDynamicFwrFormField(tester, testItems, (_) {
        // do nothing for test
      });
      await tester.tap(firstItemDeleteButtonFinder);
      await tester.pumpAndSettle();
      verifyInfoNotShown(itemToDelete);

      verifyNoDuplicateInfoShown([
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-13 18:22"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 1",
                city: "FWR city 1",
                provinceOrState: "FWR province 1",
                country: "FWR country 1",
                postalCode: "234rty"),
            fwrProvidedOnboard: false),
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-14 04:20"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 3",
                city: "FWR city 3",
                provinceOrState: "FWR province 3",
                country: "FWR country 3",
                postalCode: "789hjk"),
            fwrProvidedOnboard: false)
      ]);
    });

    testWidgets('delete button pressed removes field, leaves empty list',
        (WidgetTester tester) async {
      final testItemToDelete = testFwrEvent();
      final deleteButtonFinder = find.byIcon(Icons.delete);
      await pumpDynamicFwrFormField(tester, [testItemToDelete], (_) {
        // do nothing for test
      });
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("No events, try adding some!"), findsOneWidget);
    });

    testWidgets('add button pressed adds empty field',
        (WidgetTester tester) async {
      await pumpDynamicFwrFormField(tester, <FeedWaterRestEvent>[], (_) {
        // do nothing for test
      });
      final addButtonFinder = find.byIcon(Icons.add);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      verifyOneEmptyFwrEventShown(FeedWaterRestEvent(
          animalsWereUnloaded: true,
          fwrTime: DateTime.now(),
          lastFwrLocation: Address(
              streetAddress: "",
              city: "",
              provinceOrState: "",
              country: "",
              postalCode: ""),
          fwrProvidedOnboard: false));
      expect(find.text("No events, try adding some!"), findsNothing);
    });

    testWidgets('onSaved called when info is edited',
        (WidgetTester tester) async {
      final testItems = [
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
            fwrTime: DateTime.parse("2021-05-12 23:00"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 2",
                city: "FWR city 2",
                provinceOrState: "FWR province 2",
                country: "FWR country 2",
                postalCode: "456uio"),
            fwrProvidedOnboard: false),
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-13 04:20"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 3",
                city: "FWR city 3",
                provinceOrState: "FWR province 3",
                country: "FWR country 3",
                postalCode: "789hjk"),
            fwrProvidedOnboard: false)
      ];

      List<FeedWaterRestEvent> callback;
      final onSaved = (List<FeedWaterRestEvent> changed) => callback = changed;
      final fieldFinder = find.text("FWR location 2");
      await pumpDynamicFwrFormField(tester, testItems, onSaved);
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, "FWR location for resting");
      await tester.pumpAndSettle();

      expect(callback, [
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
            fwrTime: DateTime.parse("2021-05-12 23:00"),
            lastFwrLocation: Address(
                streetAddress: "FWR location for resting",
                city: "FWR city 2",
                provinceOrState: "FWR province 2",
                country: "FWR country 2",
                postalCode: "456uio"),
            fwrProvidedOnboard: false),
        FeedWaterRestEvent(
            animalsWereUnloaded: true,
            fwrTime: DateTime.parse("2021-05-13 04:20"),
            lastFwrLocation: Address(
                streetAddress: "FWR location 3",
                city: "FWR city 3",
                provinceOrState: "FWR province 3",
                country: "FWR country 3",
                postalCode: "789hjk"),
            fwrProvidedOnboard: false)
      ]);
    });
  });
}
