import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signIn({
    @required String email,
    @required String password,
  }) async =>
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

  Future<void> signOut() async => _firebaseAuth.signOut();
}
