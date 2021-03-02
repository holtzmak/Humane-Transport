import 'dart:async';

import 'package:app/core/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  FirestoreUser _currentUser;

  FirestoreUser get currentUser => _currentUser;

  AuthenticationService(
      {@required this.firebaseAuth, @required this.firebaseFirestore});

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
