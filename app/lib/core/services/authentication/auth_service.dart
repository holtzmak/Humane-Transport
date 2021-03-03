import 'dart:async';

import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// A service wrapping FirebaseAuth
/// Sign in persistence is guaranteed default as per https://firebase.flutter.dev/docs/auth/usage/#persisting-authentication-state
class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  // The logged in user information is the same as the Transporter information
  // but separate for Firebase Authentication
  Optional<User> _currentUser;

  Optional<User> get currentUser => _currentUser;

  // Stream available to any class needing to listen actively to changes
  Stream<Optional<User>> currentUserChanges() => firebaseAuth
      .authStateChanges()
      .map((User user) => _currentUser = Optional.of(user));

  AuthenticationService(
      {@required this.firebaseAuth, @required this.firebaseFirestore}) {
    // Internal stream to update the one-time get currentUser
    firebaseAuth
        .authStateChanges()
        .listen((User user) => _currentUser = Optional.of(user));
  }

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
          .then((authResult) => addUserToFirestore(FirestoreUser(
                userId: authResult.user.uid,
                firstName: firstName,
                lastName: lastName,
                userEmailAddress: userEmailAddress,
                userPhoneNumber: userPhoneNumber,
                // SignUp for admin is not done through this application
                isAdmin: false,
              )));

  Future<void> addUserToFirestore(FirestoreUser user) async =>
      firebaseFirestore.collection('users').doc(user.userId).set(user.toJSON());

  Future<void> signOut() async => firebaseAuth.signOut();
}
