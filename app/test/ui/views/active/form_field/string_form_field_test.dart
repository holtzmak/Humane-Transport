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
        onDelete: Optional.empty(),
      );
      await pumpStringFormField(tester, widget);
      verifyInformationIsShown(testItem, testTitle);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      final testItem = "Test";
      String callbackInfo;
      final onSavedCallback = (String info) => callbackInfo = info;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = StringFormField(
        initial: testItem,
        title: "Test Title",
        onDelete: Optional.of(onSavedCallback),
      );

      await pumpStringFormField(tester, widget);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testItem);
    });

    testWidgets('has no onDelete', (WidgetTester tester) async {
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = StringFormField(
        initial: "Test",
        title: "Test Title",
        onDelete: Optional.empty(),
      );
      await pumpStringFormField(tester, widget);
      expect(deleteButtonFinder, findsNothing);
    });

    testWidgets('getString with info', (WidgetTester tester) async {
      final testInfo = "Test";
      final widget = StringFormField(
        initial: testInfo,
        title: "Test Title",
        onDelete: Optional.empty(),
      );
      await pumpStringFormField(tester, widget);
      expect(widget.getString(), testInfo);
    });

    testWidgets('getString with edited info', (WidgetTester tester) async {
      final testInfo = "Test";
      final editedTestInfo = "EditedTest";
      final fieldFinder = find.widgetWithText(ListTile, testInfo);
      final widget = StringFormField(
        initial: testInfo,
        title: "Test Title",
        onDelete: Optional.empty(),
      );

      await pumpStringFormField(tester, widget);
      await tester.enterText(fieldFinder, editedTestInfo);
      expect(editedTestInfo, widget.getString());
    });
  });
}
