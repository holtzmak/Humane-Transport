import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/acknowledgement_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAckInfoFormField(
          WidgetTester tester,
          AcknowledgementInfo testInfo,
          Function(AcknowledgementInfo) callback) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: AcknowledgementInfoFormField(
            initialInfo: testInfo, onSaved: callback),
      )))));

  group('Acknowledgement Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {});

    testWidgets('shows save button', (WidgetTester tester) async {
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      await pumpAckInfoFormField(tester, testAckInfo(), (_) {
        // Do nothing for test
      });
      await tester.ensureVisible(saveButtonFinder);
      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets('calls onSaved when save button pressed',
        (WidgetTester tester) async {
      final testInfo = testAckInfo();
      final saveButtonFinder = find.widgetWithText(RaisedButton, "Save");
      AcknowledgementInfo callbackInfo;
      final onSavedCallback = (AcknowledgementInfo info) => callbackInfo = info;

      await pumpAckInfoFormField(tester, testInfo, onSavedCallback);
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
      expect(callbackInfo, testInfo);
    });

    testWidgets('calls onSaved when acknowledgement edited',
        (WidgetTester tester) async {});
  });
}
