import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  AuthRepository(this._firebaseAuth, this._googleSignIn, this._facebookLogin);

  Future<FirebaseUser> loginWithFacebook() async {
    final facebookPermissions = ['email', 'public_profile'];  // TODO: get needed permissions
    final result = await _facebookLogin.logIn(facebookPermissions);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
      await _firebaseAuth.signInWithCredential(credential);
    }

    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithCredentials(String email, String password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    final AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await result.user.sendEmailVerification();

    return result.user;
  }

  Future<void> sendEmailVerification() async {
    final user = await _firebaseAuth.currentUser();
    await user.sendEmailVerification();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> deleteUser() async {
    final user = await _firebaseAuth.currentUser();
    await user.delete();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email; // TODO: return whole user
  }

  Future<void> forgotPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
