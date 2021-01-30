import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    // TODO: Should handle exception error
    await _firebaseAuth.signOut();
  }

  void user() {
    // ignore: deprecated_member_use
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return null;
      } else {
        return user;
      }
    });
  }
}
