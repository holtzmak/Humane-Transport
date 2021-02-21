import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(String infoExpected, String titleExpected) {
    expect(find.widgetWithText(ListTile, infoExpected), findsOneWidget);
    expect(find.widgetWithText(ListTile, titleExpected), findsOneWidget);
  }

  Future<void> pumpStringFormField(
          WidgetTester tester, StringFormField widget) async =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

  group('String Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testItem = "Test";
      final testTitle = "Test Title";
      final widget = StringFormField(
        initial: testItem,
        title: testTitle,
        onSaved: (String _) {
          // do nothing for test
        },
        onDelete: Optional.empty(),
      );
      await pumpStringFormField(tester, widget);
      verifyInformationIsShown(testItem, testTitle);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool wasCallback;
      final onDeleteCallback = () => wasCallback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = StringFormField(
        initial: "Test",
        title: "Test Title",
        onSaved: (String _) {
          // do nothing for test
        },
        onDelete: Optional.of(onDeleteCallback),
      );

      await pumpStringFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(wasCallback, isTrue);
    });

    testWidgets('has no onDelete', (WidgetTester tester) async {
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = StringFormField(
        initial: "Test",
        title: "Test Title",
        onSaved: (String _) {
          // do nothing for test
        },
        onDelete: Optional.empty(),
      );
      await pumpStringFormField(tester, widget);
      expect(deleteButtonFinder, findsNothing);
    });

    testWidgets('onSaved called when edited', (WidgetTester tester) async {
      final testInfo = "Test";
      final editedInfo = "Edited";
      String callback;
      final onSavedCallback = (String changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, testInfo);
      final editedFieldFinder = find.widgetWithText(TextFormField, editedInfo);
      final widget = StringFormField(
        initial: testInfo,
        title: "Test Title",
        onSaved: onSavedCallback,
        onDelete: Optional.empty(),
      );

      await pumpStringFormField(tester, widget);
      await tester.enterText(fieldFinder, editedInfo);
      await tester.pumpAndSettle();
      // expect was saved
      expect(callback, editedInfo);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
