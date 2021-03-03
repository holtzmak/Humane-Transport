import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/sign_in_view_model.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';
import 'package:app/ui/views/signup/sign_up_screen.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockSignInViewModel extends Mock implements SignInViewModel {}

class MockNavigationService extends Mock implements NavigationService {}

final GetIt testLocator = GetIt.instance;
final mockSignInViewModel = MockSignInViewModel();
final mockNavigationService = MockNavigationService();
final userEmailAddress = "testemail@mail.com";
final password = "ABC123";
final mockSignInRoute = '/signIn';

void main() {
  Future<void> pumpSignInScreen(WidgetTester tester) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: SignInScreen(),
      )));

  group('Sign in screen', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<NavigationService>(
          () => mockNavigationService);
      testLocator.registerFactory<SignInViewModel>(() => mockSignInViewModel);
    });

    testWidgets('calls sign in with user credentials on sign in button clicked',
        (WidgetTester tester) async {
      await pumpSignInScreen(tester);

      // Enter into screen
      final emailFinder = find.byKey(ObjectKey("Email"));
      final passwordFinder = find.byKey(ObjectKey('Password'));
      await tester.enterText(emailFinder, "email@email.com");
      await tester.enterText(passwordFinder, "Test pas");
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      final signInButtonFinder = find.widgetWithText(RaisedButton, "Sign In");
      await tester.ensureVisible(signInButtonFinder);
      await tester.tap(signInButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      verify(mockSignInViewModel.signIn(
        email: "email@email.com",
        password: "Test pas",
      )).called(1);
    });

    testWidgets('shows register button', (WidgetTester tester) async {
      final signInButtonFinder = find.widgetWithText(RaisedButton, "Sign In");
      await pumpSignInScreen(tester);
      await tester.ensureVisible(signInButtonFinder);
      expect(signInButtonFinder, findsOneWidget);
    });

    testWidgets('goes back to welcome screen on button clicked',
        (WidgetTester tester) async {
      await pumpSignInScreen(tester);
      final goBackButtonFinder =
          find.widgetWithText(TextButton, 'Go back to welcome screen');
      await tester.ensureVisible(goBackButtonFinder);
      expect(goBackButtonFinder, findsOneWidget);
      await tester.tap(goBackButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));
      verify(mockNavigationService.navigateTo(WelcomeScreen.route)).called(1);
    });

    testWidgets('navigate to sign up screen on button clicked',
        (WidgetTester tester) async {
      await pumpSignInScreen(tester);
      final dontHaveAnAccountButtonFinder = find.widgetWithText(
          TextButton, 'Do not have an account? Sign Up Here');
      await tester.ensureVisible(dontHaveAnAccountButtonFinder);
      expect(dontHaveAnAccountButtonFinder, findsOneWidget);
      await tester.tap(dontHaveAnAccountButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));
      verify(mockNavigationService.navigateTo(SignUpScreen.route)).called(1);
    });

    testWidgets('empty field validators appears on empty fields',
        (WidgetTester tester) async {
      await pumpSignInScreen(tester);

      final signInButtonFinder = find.widgetWithText(RaisedButton, "Sign In");
      await tester.ensureVisible(signInButtonFinder);
      await tester.tap(signInButtonFinder);
      // Non-standard animation time due to decoration
      await tester.pump(Duration(milliseconds: 1));

      final validatorTextFinder = find.text("* Required");
      expect(validatorTextFinder, findsNWidgets(2));

      verifyNever(mockSignInViewModel.signIn(
        email: userEmailAddress,
        password: password,
      ));
    });
  });
}
