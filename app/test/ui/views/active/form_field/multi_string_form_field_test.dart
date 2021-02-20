import 'package:app/ui/views/active/form_field/multi_string_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyNoDuplicateInfoShown(String title, List<String> information) {
    expect(find.widgetWithText(ListTile, title),
        findsNWidgets(information.length));
    information.forEach((info) {
      expect(find.widgetWithText(ListTile, info), findsOneWidget);
    });
  }

  Future<void> pumpStringFormField(
          WidgetTester tester, MultiStringFormField widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: widget,
      )));

  group('Multi String Form Field', () {
    testWidgets('shows right information for multiple fields',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, testItems);
    });

    testWidgets('shows no information when no fields',
        (WidgetTester tester) async {
      final widget = MultiStringFormField(
        initialList: <String>[],
        titles: "Test Title",
      );
      await pumpStringFormField(tester, widget);
      expect(find.text("No fields, try adding some!"), findsOneWidget);
    });

    testWidgets('delete button pressed removes field',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final firstItemDeleteButtonFinder = find.byIcon(Icons.delete).last;
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );

      await pumpStringFormField(tester, widget);
      await tester.tap(firstItemDeleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("Test2"), findsNothing);
      verifyNoDuplicateInfoShown(testTitle, ["Test0", "Test1"]);
    });

    testWidgets('delete button pressed removes field, leaves empty list',
        (WidgetTester tester) async {
      final testItems = ["Test0"];
      final testTitle = "Test Title";
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("No fields, try adding some!"), findsOneWidget);
    });

    testWidgets('add button pressed adds empty field',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final widget = MultiStringFormField(
        initialList: <String>[],
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      final addButtonFinder = find.widgetWithText(RaisedButton, "Add field");
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, [""]);
    });

    testWidgets('getList with info', (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = ["Test0", "Test1", "Test2"];
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      expect(widget.getList(), testItems);
    });

    testWidgets('getList with empty info', (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = <String>[];
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      expect(widget.getList(), testItems);
    });

    testWidgets('getList with edited info', (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = ["Test0", "Test1", "Test2"];
      final editedItems = ["Test3", "Test1", "Test2"];
      final fieldFinder = find.text("Test0");
      final widget = MultiStringFormField(
        initialList: testItems,
        titles: testTitle,
      );
      await pumpStringFormField(tester, widget);
      await tester.enterText(fieldFinder, "Test3");
      expect(widget.getList(), editedItems);
    });
  });
}
