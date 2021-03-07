import 'dart:async';

import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// A service wrapping FirebaseAuth
/// Sign in persistence is guaranteed default as per https://firebase.flutter.dev/docs/auth/usage/#persisting-authentication-state
class AuthenticationService {
  final databaseService = locator<DatabaseService>();
  final FirebaseAuth firebaseAuth;

  // Not disposed of in destructor because AuthService goes out of scope when
  // app is destroyed. The disposal is handled by garbage cleanup. Also, Dart
  // does not define destructors https://github.com/dart-lang/sdk/issues/3691
  StreamSubscription<User> _authStateChanges;

  // The logged in user information is the same as the Transporter information
  // but separate for Firebase Authentication
  Optional<User> _currentUser = Optional.empty();

  Optional<User> get currentUser => _currentUser;

  Stream<Optional<User>> currentUserChanges;

  // Also not truly disposed of. See above comment.
  final StreamController<Optional<User>> _currentUserChangesStream =
      StreamController<Optional<User>>.broadcast();

  void dispose() async {
    _currentUserChangesStream.close();
    _authStateChanges.cancel();
  }

  AuthenticationService({@required this.firebaseAuth}) {
    currentUserChanges = _currentUserChangesStream.stream;
    _authStateChanges =
        firebaseAuth.authStateChanges().listen((User userMaybe) async {
      _currentUser = Optional.of(userMaybe);
      _currentUserChangesStream.add(Optional.of(userMaybe));
    });
  }

  Future<void> signOut() async => firebaseAuth.signOut();

  Future<UserCredential> signIn({
    @required String email,
    @required String password,
  }) async =>
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signUp({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
    @required String password,
  }) async =>
      firebaseAuth
          .createUserWithEmailAndPassword(
            email: userEmailAddress,
            password: password,
          )
          .then((authResult) => databaseService.addTransporter(Transporter(
                userId: authResult.user.uid,
                firstName: firstName,
                lastName: lastName,
                userEmailAddress: userEmailAddress,
                userPhoneNumber: userPhoneNumber,
                // SignUp for admin is not done through this application
                isAdmin: false,
              )));

  Future<void> deleteAccount() async => _currentUser.isPresent()
      ? databaseService
          .removeTransporter(_currentUser.get().uid)
          .then((_) => firebaseAuth.currentUser.delete())
      : Future.error("No user is logged in to delete their account");
}
