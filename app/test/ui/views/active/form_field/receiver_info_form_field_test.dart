import 'package:app/core/models/receiver_info.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/test/helper/test_receiver_info_expectations.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/views/active/form_field/receiver_info_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpReceiverInfoFormField(
          WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
        child: widget,
      ))));

  group('Receiver Info Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testReceiverInfo = ReceiverInfo(
          receiverCompanyName: "Tester Company",
          receiverName: "Kelly Holds",
          accountId: Optional.empty(),
          destinationLocationId: "ert456",
          destinationLocationName: "Tester Company Farms",
          destinationAddress: testAddress(),
          receiverContactInfo: "By phone: 3061111111");
      final widget = ReceiverInfoFormField(
        initialInfo: testReceiverInfo,
        onSaved: (_) {
          // do nothing for test
        },
      );
      await pumpReceiverInfoFormField(tester, widget);
      verifyReceiverInfoIsShown(testReceiverInfo);
    });

    testWidgets('onSaved called when account ID info edited',
        (WidgetTester tester) async {
      final testAccountId = Optional<String>.empty();
      final editedAccountId = Optional.of("123");
      ReceiverInfo callback;
      final onSavedCallback = (ReceiverInfo changed) => callback = changed;
      final fieldFinder = find.widgetWithText(TextFormField, "");
      final editedFieldFinder = find.widgetWithText(TextFormField, "123");
      final testRecInfo = testReceiverInfo(accountId: testAccountId);
      final editedRecInfo = testReceiverInfo(accountId: editedAccountId);

      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: ReceiverInfoFormField(
            initialInfo: testRecInfo,
            onSaved: onSavedCallback,
          ));
      await pumpReceiverInfoFormField(tester, widget);
      await tester.enterText(fieldFinder, "123");
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedRecInfo);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
