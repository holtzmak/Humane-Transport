import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/ui/views/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockSignUpViewModel extends Mock implements SignUpViewModel {}

void main() {
  GetIt locator = GetIt.instance;

  void setupLocator() {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => SignUpViewModel());
  }

  void verifyInformationIsShown(FirestoreUser infoExpected) {
    expect(find.text(infoExpected.firstName), findsOneWidget);
    expect(find.text(infoExpected.lastName), findsOneWidget);
    expect(find.text(infoExpected.userEmailAddress), findsOneWidget);
    expect(find.text(infoExpected.userPhoneNumber), findsOneWidget);
  }

  Future<void> pumpSignUpScreen(
          WidgetTester tester, FirestoreUser testInfo) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: SignUpScreen(),
      )))));

  group('Login Info Form Field', () {
    setupLocator();
    testWidgets('shows right information', (WidgetTester tester) async {
      final testFirestoreUser = FirestoreUser(
          firstName: "First Name",
          lastName: "LAst Name",
          userEmailAddress: 'Email',
          userPhoneNumber: "Phone Number");
      verifyInformationIsShown(testFirestoreUser);
    });

    testWidgets('shows register button', (WidgetTester tester) async {
      final registerButtonFinder =
          find.widgetWithText(RaisedButton, "Register");
      await tester.pumpWidget(SignUpScreen());
      await tester.ensureVisible(registerButtonFinder);
      expect(registerButtonFinder, findsOneWidget);
    });
  });
}
