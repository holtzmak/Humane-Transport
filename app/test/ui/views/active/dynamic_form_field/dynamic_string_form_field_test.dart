import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
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

  Future<void> pumpDynamicStringFormField(WidgetTester tester,
          DynamicFormField<String, StringFormField> widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: widget,
      )));

  group('Dynamic String Form Field', () {
    testWidgets('shows right information for multiple fields',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, testItems);
    });

    testWidgets('shows no information when no fields',
        (WidgetTester tester) async {
      final widget = dynamicStringFormField(
        initialList: <String>[],
        titles: "Test Title",
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      expect(find.text("No Test Title, add some using the + button"),
          findsOneWidget);
    });

    testWidgets('delete button pressed removes field',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final firstItemDeleteButtonFinder = find.byIcon(Icons.delete).first;
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );

      await pumpDynamicStringFormField(tester, widget);
      await tester.tap(firstItemDeleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("Test0"), findsNothing);
      verifyNoDuplicateInfoShown(testTitle, ["Test1", "Test2"]);
    });

    testWidgets('delete button pressed removes field, leaves empty list',
        (WidgetTester tester) async {
      final testItems = ["Test0"];
      final testTitle = "Test Title";
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("No $testTitle, add some using the + button"),
          findsOneWidget);
    });

    testWidgets('add button pressed adds empty field',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final widget = dynamicStringFormField(
        initialList: <String>[],
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      final addButtonFinder = find.byIcon(Icons.add);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, [""]);
      expect(find.text("No $testTitle, add some using the + button"),
          findsNothing);
    });

    testWidgets('onSaved called when info is edited',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = ["Test0", "Test1", "Test2"];
      final editedItems = ["Test3", "Test1", "Test2"];
      List<String> callback;
      final onSaved = (List<String> changed) => callback = changed;
      final fieldFinder = find.text("Test0");
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: onSaved,
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.enterText(fieldFinder, "Test3");
      await tester.pumpAndSettle();
      expect(callback, editedItems);
    });
  });
}
