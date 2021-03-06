import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
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
  final testTransporter = Transporter(
      firstName: firstName,
      lastName: lastName,
      userEmailAddress: userEmailAddress,
      userPhoneNumber: userPhoneNumber,
      userId: testUserId,
      isAdmin: false);
  final mockDatabaseService = MockDatabaseService();
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();

  void setUpFirebaseAuthMock() {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: userEmailAddress, password: password))
        .thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn(testUserId);
  }

  void setUpDatabaseServiceMock() {
    when(mockDatabaseService.getTransporter(testUserId))
        .thenAnswer((_) => Future.value(testTransporter));
  }

  void setUpAuthChangesMockUser() {
    // Mock stream
    Stream<User> authStateChanges() async* {
      yield mockUser;
    }

    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => authStateChanges());
  }

  group('Authentication Service', () {
    setUpAll(() async {
      testLocator
          .registerLazySingleton<DatabaseService>(() => mockDatabaseService);
    });

    test('sign up successful calls add transporter', () async {
      setUpAuthChangesMockUser();
      setUpFirebaseAuthMock();
      setUpDatabaseServiceMock();
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
      try {
        await AuthenticationService(firebaseAuth: mockFirebaseAuth)
            .deleteAccount();
      } catch (e) {
        expect(e, "No user is logged in to delete their account");
      }
    });
  });
}
