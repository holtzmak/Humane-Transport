import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider(this._firebaseAuth);

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // TODO: Handle errors like password incorrect/user not found
      // TODO: Update UI with the error message
      print(e.code);
    }
  }

  // TODO: Create Account
  Future<void> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      // TODO: Handle errors like user already exist
      // TODO: Update UI with the error message
    }
  }

  void signOut() async {
    // TODO: Should handle exception error
    await _firebaseAuth.signOut();
  }

// TODO: Update account information

// TODO: Delete account
}
