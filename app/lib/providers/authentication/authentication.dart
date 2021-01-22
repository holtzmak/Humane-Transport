import 'package:app/common/enums/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ViewState _viewState;

  ViewState get viewState => _viewState;

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({String email, String password}) async {
    try {
      setViewState(ViewState.Busy);
      await Future.delayed(Duration(seconds: 8));
      print(viewState);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      setViewState(ViewState.Idle);
      print(viewState);
    } on FirebaseAuthException catch (e) {
      // TODO: Handle errors like password incorrect/user not found
      // TODO: Update UI with the error message
      setViewState(ViewState.Idle);
      print(e.code);
    }
  }

  // TODO: Create Account
  Future<void> signUp({String email, String password}) async {
    try {
      setViewState(ViewState.Busy);
      await Future.delayed(Duration(seconds: 8));
      print(viewState);
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
