import 'dart:async';

import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/test/mock/test_mocks_for_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockDatabaseService extends Mock implements DatabaseService {}

final testLocator = GetIt.instance;

void main() {
  final firstName = "testName";
  final lastName = "testLastName";
  final userEmailAddress = "testemail@mail.com";
  final userPhoneNumber = "ABC123";
  final password = "ABCD";
  final testUserId = "testID";
  final mockDatabaseService = MockDatabaseService();
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();
  final mockAuthStateChangesController = StreamController<User>.broadcast();

  void setUpFirebaseAuthMock() {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: userEmailAddress, password: password))
        .thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn(testUserId);
  }

  void setUpAuthChangesMockUser() {
    // Mock stream
    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => mockAuthStateChangesController.stream);
  }

  group('Authentication Service', () {
    setUpAll(() async {
      testLocator
          .registerLazySingleton<DatabaseService>(() => mockDatabaseService);
    });
    tearDownAll(() async => mockAuthStateChangesController.close());

    test('sign up successful calls add transporter', () async {
      setUpAuthChangesMockUser();
      setUpFirebaseAuthMock();
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      when(mockDatabaseService.addTransporter(any))
          .thenAnswer((_) => Future.value()); // do nothing for test
      final authService = AuthenticationService(firebaseAuth: mockFirebaseAuth);

      try {
        await authService.signUp(
            firstName: firstName,
            lastName: lastName,
            userEmailAddress: userEmailAddress,
            userPhoneNumber: userPhoneNumber,
            password: password);
      } catch (e) {
        // This test should pass
        fail(e);
      }
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: userEmailAddress, password: password))
          .called(1);
      verify(mockDatabaseService.addTransporter(any)).called(1);
    });

    test('sign up failed, create user failed', () async {
      setUpAuthChangesMockUser();
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: userEmailAddress, password: password))
          .thenAnswer((_) async => Future.error('Error Here'));
      try {
        await AuthenticationService(firebaseAuth: mockFirebaseAuth).signUp(
            firstName: firstName,
            lastName: lastName,
            userEmailAddress: userEmailAddress,
            userPhoneNumber: userPhoneNumber,
            password: password);
      } catch (e) {
        expect(e, 'Error Here');
      }
    });

    test('delete account failed, not logged in', () async {
      setUpAuthChangesMockUser();
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      try {
        await AuthenticationService(firebaseAuth: mockFirebaseAuth)
            .deleteAccount();
      } catch (e) {
        expect(e, "No user is logged in to delete their account");
      }
    });

    test(
        'current user stream updates when current user changes, getCurrentUser updates too',
        () async {
      setUpAuthChangesMockUser();
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      final authService = AuthenticationService(firebaseAuth: mockFirebaseAuth);

      expectLater(
          authService.currentUserChanges,
          emitsInOrder(
              [Optional.empty(), Optional.of(mockUser), Optional.empty()]));

      // Start state
      mockAuthStateChangesController.add(null);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));

      mockAuthStateChangesController.add(mockUser);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));
      expect(authService.currentUser, Optional.of(mockUser));

      mockAuthStateChangesController.add(null);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));
      expect(authService.currentUser, Optional.empty());
    });
  });
}
