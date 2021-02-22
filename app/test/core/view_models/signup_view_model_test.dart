import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockNavigationService extends Mock implements NavigationService {}

class MockDialogService extends Mock implements DialogService {}

final testLocator = GetIt.instance;

void main() {
  final mockAuthenticationService = MockAuthenticationService();
  final mockNavigationService = MockNavigationService();
  final mockDialogService = MockDialogService();
  final mockSignInRoute = '/signIn';
  final firstName = "testName";
  final lastName = "testLastName";
  final userEmailAddress = "testemail@mail.com";
  final userPhoneNumber = "ABC123";
  final password = "ABCD";

  group('SignUp ViewModel', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<AuthenticationService>(
          () => mockAuthenticationService);
      testLocator.registerLazySingleton<NavigationService>(
          () => mockNavigationService);
      testLocator.registerLazySingleton<DialogService>(() => mockDialogService);
    });

    test('Succeed to Navigate to SignInPage after SignUp', () async {
      when(mockAuthenticationService.signUp(
              userEmailAddress: userEmailAddress,
              password: password,
              firstName: firstName,
              lastName: lastName,
              userPhoneNumber: userPhoneNumber))
          .thenAnswer((_) async => Future.value()); // successful return
      when(mockNavigationService.navigateTo(any)).thenAnswer(
          (_) async => Future.value()); // ignore return for this test

      await SignUpViewModel().signUp(
          firstName: firstName,
          lastName: lastName,
          userEmailAddress: userEmailAddress,
          userPhoneNumber: userPhoneNumber,
          password: password);
      verify(mockAuthenticationService.signUp(
              userEmailAddress: userEmailAddress,
              password: password,
              firstName: firstName,
              lastName: lastName,
              userPhoneNumber: userPhoneNumber))
          .called(1);
      verify(mockNavigationService.navigateTo(any)).called(1);
    });

    test('failed to Navigate to SignInPage after SignUp', () async {
      when(mockAuthenticationService.signUp(
              userEmailAddress: userEmailAddress,
              password: password,
              firstName: firstName,
              lastName: lastName,
              userPhoneNumber: userPhoneNumber))
          .thenAnswer((_) async => Future.error(
              FirebaseAuthException(message: "Error here", code: "Test")));
      when(mockDialogService.showDialog(
              title: "Sign up failed", description: anyNamed("description")))
          .thenAnswer((_) => Future.value()); // ignore return for this test

      await SignUpViewModel().signUp(
          firstName: firstName,
          lastName: lastName,
          userEmailAddress: userEmailAddress,
          userPhoneNumber: userPhoneNumber,
          password: password);
      verify(mockAuthenticationService.signUp(
              userEmailAddress: userEmailAddress,
              password: password,
              firstName: firstName,
              lastName: lastName,
              userPhoneNumber: userPhoneNumber))
          .called(1);
      verifyNever(mockNavigationService.navigateTo(mockSignInRoute));
      verify(mockDialogService.showDialog(
              title: "Sign up failed", description: anyNamed("description")))
          .called(1);
    });
  });
}
