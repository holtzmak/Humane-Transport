import 'dart:async';
import 'package:app/core/enums/auth_result_status.dart';
import 'package:app/core/models/user_info.dart';
import 'package:app/core/services/firestore/firestore_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  ResultStatus _status;
  UserInformation _currentUser;
  UserInformation get currentUser => _currentUser;

  Future<ResultStatus> signIn({
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

      if (user != null) {
        await _populateCurrentUser(authResult.user);
        _status = ResultStatus.successful;
      } else {
        _status = ResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = ExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<ResultStatus> signUp({
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

      if (authResult.user != null) {
        // Uses the service to create a new user to Firestore
        await _firestoreService.addUserToFirestore(UserInformation(
          userId: authResult.user.uid,
          firstName: firstName,
          lastName: lastName,
          userEmailAddress: userEmailAddress,
          userPhoneNumber: userPhoneNumber,
        ));
        _status = ResultStatus.successful;
      } else {
        _status = ResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = ExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      _status = ExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<dynamic> isLoggedIn() async {
    var firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return false;
    try {
      var user = await _firestoreService.fetchUser(firebaseUser.uid);

      if (user != null) {
        await _populateCurrentUser(firebaseUser);
        _status = ResultStatus.isLoggedIn;
      } else {
        _status = ResultStatus.undefined;
      }
      return _status;
    } on FirebaseAuthException catch (e) {
      _status = ExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<void> _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.fetchUser(user.uid);
    }
  }
}
