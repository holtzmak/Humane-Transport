import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/view_models/sign_in_view_model.dart';
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
  final mockHomeScreenRoute = '/history';
  final userEmailAddress = "mp@gmail.com";
  final password = "123-123";

  group('SignIn ViewModel', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<AuthenticationService>(
          () => mockAuthenticationService);
      testLocator.registerLazySingleton<NavigationService>(
          () => mockNavigationService);
      testLocator.registerLazySingleton<DialogService>(() => mockDialogService);
    });

    test('Succeed to Navigate to HomeScreen after SignIn', () async {
      when(mockAuthenticationService.signIn(
        email: userEmailAddress,
        password: password,
      )).thenAnswer((_) async => Future.value()); // successful return
      when(mockNavigationService.navigateTo(any)).thenAnswer(
          (_) async => Future.value()); // ignore return for this test

      await SignInViewModel()
          .signIn(email: userEmailAddress, password: password);
      verify(mockAuthenticationService.signIn(
        email: userEmailAddress,
        password: password,
      )).called(1);
      verify(mockNavigationService.navigateTo(any)).called(1);
    });

    test('failed to Navigate to HomeScreen after SignIn', () async {
      when(mockAuthenticationService.signIn(
        email: userEmailAddress,
        password: password,
      )).thenAnswer((_) async => Future.error(
          FirebaseAuthException(message: "Error here", code: "Test")));
      when(mockDialogService.showDialog(
              title: "Sign In failed", description: anyNamed("description")))
          .thenAnswer((_) => Future.value()); // ignore return for this test

      await SignInViewModel()
          .signIn(email: userEmailAddress, password: password);
      verify(mockAuthenticationService.signIn(
        email: userEmailAddress,
        password: password,
      )).called(1);
      verifyNever(mockNavigationService.navigateTo(mockHomeScreenRoute));
      verify(mockDialogService.showDialog(
              title: "Sign in failed", description: anyNamed("description")))
          .called(1);
    });
  });
}
