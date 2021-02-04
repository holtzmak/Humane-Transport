import 'dart:async';
import 'package:app/core/models/user_info.dart';
import 'package:app/core/services/firestore/firestore_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  UserInformation _currentUser;
  UserInformation get currentUser => _currentUser;

  /*
   This needs to be a dynamic type as we may expect bool or a string as return type.
   Note: Same logic applies to other methods here.
  [FirebaseAuthException] - Will return String if something went wrong
  */
  Future signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = await _firestoreService.fetchUser(authResult.user.uid);
      var isUserExist = user != null;

      await _populateCurrentUser(authResult.user);

      print('${user.firstName} currently signed in!');
      return isUserExist;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future signUp({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
    @required String password,
  }) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmailAddress,
        password: password,
      );

      // Uses the service to create a new user to Firestore
      await _firestoreService.addUserToFirestore(UserInformation(
        userId: authResult.user.uid,
        firstName: firstName,
        lastName: lastName,
        userEmailAddress: userEmailAddress,
        userPhoneNumber: userPhoneNumber,
      ));

      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future isLoggedIn() async {
    var firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return false;

    try {
      var user = await _firestoreService.fetchUser(firebaseUser.uid);
      var isUserExist = user != null;

      /*
      As soon as the system confirmed a user is logged in, populate
      user information to be readily available.
      */
      await _populateCurrentUser(firebaseUser);

      return isUserExist;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future _populateCurrentUser(User user) async {
    try {
      if (user != null) {
        _currentUser = await _firestoreService.fetchUser(user.uid);
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
