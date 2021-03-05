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

  // The logged in user information is the same as the Transporter information
  // but separate for Firebase Authentication
  Optional<User> _currentUser;
  Optional<Transporter> _currentTransporter;

  Optional<User> get currentUser => _currentUser;

  Optional<Transporter> get currentTransporter => _currentTransporter;

  Stream<Optional<User>> currentUserChanges() => firebaseAuth
      .authStateChanges()
      .map((User user) => _currentUser = Optional.of(user));

  Stream<Optional<Transporter>> currentTransporterChanges() =>
      currentUserChanges().map((_) => _currentTransporter);

  AuthenticationService({@required this.firebaseAuth}) {
    // Internal stream to update the one-time get currentUser
    firebaseAuth.authStateChanges().listen((User user) async {
      _currentUser = Optional.of(user);
      _currentTransporter = _currentUser.isPresent()
          ? Optional.of(await databaseService.getTransporter(user.uid))
          : Optional.empty();
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
