import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/ui/views/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockSignUpViewModel extends Mock implements SignUpViewModel {}

class MockNavigationService extends Mock implements NavigationService {}

final GetIt testLocator = GetIt.instance;
final mockSignUpViewModel = MockSignUpViewModel();
final mockNavigationService = MockNavigationService();

void main() {
  Future<void> pumpSignUpScreen(WidgetTester tester) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: SignUpScreen(),
      )));

  group('Sign up screen', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<NavigationService>(
          () => MockNavigationService());
      testLocator.registerFactory<SignUpViewModel>(() => mockSignUpViewModel);
    });

    testWidgets(
        'calls sign up with user information on register button clicked',
        (WidgetTester tester) async {
      await pumpSignUpScreen(tester);

      // Enter into screen
      final firstNameFinder = find.byKey(ObjectKey("First Name"));
      final lastNameFinder = find.byKey(ObjectKey("Last Name"));
      final emailFinder = find.byKey(ObjectKey("Email"));
      final phoneFinder = find.byKey(ObjectKey("Phone Number"));
      final passwordFinder = find.byKey(ObjectKey('Password'));
      await tester.enterText(firstNameFinder, "Test first name");
      await tester.enterText(lastNameFinder, "Test last name");
      await tester.enterText(emailFinder, "email@email.com");
      await tester.enterText(phoneFinder, "Test phone number");
      await tester.enterText(passwordFinder, "Test pas");
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      final registerButtonFinder =
          find.widgetWithText(RaisedButton, "Register");
      await tester.ensureVisible(registerButtonFinder);
      await tester.tap(registerButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      verify(mockSignUpViewModel.signUp(
              userEmailAddress: "email@email.com",
              password: "Test pas",
              firstName: "Test first name",
              lastName: "Test last name",
              userPhoneNumber: "Test phone number"))
          .called(1);
    });

    testWidgets('shows register button', (WidgetTester tester) async {
      final registerButtonFinder =
          find.widgetWithText(RaisedButton, "Register");
      await pumpSignUpScreen(tester);
      await tester.ensureVisible(registerButtonFinder);
      expect(registerButtonFinder, findsOneWidget);
    });

    testWidgets('goes back to welcome screen on button clicked',
        (WidgetTester tester) async {});
    testWidgets('navigate to sign in screen on button clicked',
        (WidgetTester tester) async {});

    testWidgets('empty field validators appears on empty fields',
        (WidgetTester tester) async {
      await pumpSignUpScreen(tester);

      final registerButtonFinder =
          find.widgetWithText(RaisedButton, "Register");
      await tester.ensureVisible(registerButtonFinder);
      await tester.tap(registerButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      final validatorTextFinder = find.text("* Required");
      expect(validatorTextFinder, findsNWidgets(4));

      verifyNever(mockSignUpViewModel.signUp(
          userEmailAddress: anyNamed("userEmailAddress"),
          password: anyNamed("password"),
          firstName: anyNamed("firstName"),
          lastName: anyNamed("lastName"),
          userPhoneNumber: anyNamed("userPhoneNumber")));
    });

    testWidgets('email field validator appears on bad email',
        (WidgetTester tester) async {});
    testWidgets('password field validator appears on bad password',
        (WidgetTester tester) async {});
  });
}
