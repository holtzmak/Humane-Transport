import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/test/mock/test_mocks_for_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  final firstName = "testName";
  final lastName = "testLastName";
  final userEmailAddress = "testemail@mail.com";
  final userPhoneNumber = "ABC123";
  final password = "ABCD";
  final testUserId = "testID";
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockFirebaseFirestore = MockFirestore();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();

  void setUpMockExpectations() {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: userEmailAddress, password: password))
        .thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn(testUserId);
    when(mockFirebaseFirestore.collection('users'))
        .thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  }

  void setUpAuthChangesMockUser() {
    // Mock stream
    Stream<User> authStateChanges() async* {
      yield mockUser;
    }

    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => authStateChanges());
  }

  void setUpAuthChangesMockEmpty() {
    // Mock stream
    Stream<User> authStateChanges() async* {
      yield null;
    }

    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => authStateChanges());
  }

  group('Authentication Service', () {
    test('sign up successful', () async {
      setUpAuthChangesMockEmpty(); // Ignore for this test
      setUpMockExpectations();
      when(mockDocumentReference.set(any)).thenAnswer((_) async {
        // Successful void return
      });
      try {
        await AuthenticationService(
                firebaseAuth: mockFirebaseAuth,
                firebaseFirestore: mockFirebaseFirestore)
            .signUp(
                firstName: firstName,
                lastName: lastName,
                userEmailAddress: userEmailAddress,
                userPhoneNumber: userPhoneNumber,
                password: password);
      } catch (e) {
        // This test should pass
        fail(e);
      }
    });

    test('sign up success updates current user', () async {
      setUpAuthChangesMockUser();
      setUpMockExpectations();
      when(mockDocumentReference.set(any)).thenAnswer((_) async {
        // Successful void return
      });
      final authService = AuthenticationService(
          firebaseAuth: mockFirebaseAuth,
          firebaseFirestore: mockFirebaseFirestore);

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
      expect(true, authService.currentUser.isPresent());
      expect(mockUser, authService.currentUser.get());
    });

    test('sign up failed, create user failed', () async {
      setUpAuthChangesMockEmpty(); // Ignore for this test
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: userEmailAddress, password: password))
          .thenAnswer((_) async => Future.error('Error Here'));
      try {
        await AuthenticationService(
                firebaseAuth: mockFirebaseAuth,
                firebaseFirestore: mockFirebaseFirestore)
            .signUp(
                firstName: firstName,
                lastName: lastName,
                userEmailAddress: userEmailAddress,
                userPhoneNumber: userPhoneNumber,
                password: password);
      } catch (e) {
        expect(e, 'Error Here');
      }
    });

    test('sign up failed, add user failed', () async {
      setUpAuthChangesMockEmpty(); // Ignore for this test
      setUpMockExpectations();
      when(mockDocumentReference.set(any))
          .thenAnswer((_) async => Future.error('Error Here'));
      try {
        await AuthenticationService(
                firebaseAuth: mockFirebaseAuth,
                firebaseFirestore: mockFirebaseFirestore)
            .signUp(
                firstName: firstName,
                lastName: lastName,
                userEmailAddress: userEmailAddress,
                userPhoneNumber: userPhoneNumber,
                password: password);
      } catch (e) {
        expect(e, 'Error Here');
      }
    });
  });
}
