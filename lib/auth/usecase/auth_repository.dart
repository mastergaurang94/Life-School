import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeschool/services/user/model/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:lifeschool/services/user/repository/user_repository.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final UserRepository _userRepository;

  AuthRepository(this._firebaseAuth, this._googleSignIn, this._facebookLogin, this._userRepository);

  Future<User> loginWithFacebook() async {
    final facebookPermissions = ['email', 'public_profile']; // TODO: get needed permissions
    final result = await _facebookLogin.logIn(facebookPermissions);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
      await _firebaseAuth.signInWithCredential(credential);

      // Grab user's profile data
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,picture&access_token=${result.accessToken.token}');
      var profileData = jsonDecode(graphResponse.body);

      // Store user in Firebase collection
      FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      return await _userRepository.storeNewUser({
        'email': firebaseUser.email,
        'firstName': profileData['first_name'],
        'lastName': profileData['last_name'],
        'imageUrl': firebaseUser.photoUrl,
        'id': firebaseUser.uid
      });
    }

    return null;
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var googleResponse = await http.get('https://www.googleapis.com/oauth2/v3/userinfo?access_token=${googleAuth.accessToken}');
    var profileData = jsonDecode(googleResponse.body);

    await _firebaseAuth.signInWithCredential(credential);

    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return await _userRepository.storeNewUser({
      'email': firebaseUser.email,
      'firstName': profileData['given_name'],
      'lastName': profileData['family_name'],
      'imageUrl': firebaseUser.photoUrl,
      'id': firebaseUser.uid
    });
  }

  Future<FirebaseUser> signInWithCredentials(String email, String password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  Future<FirebaseUser> signUp(String email, String password, firstName, lastName) async {
    final AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await result.user.sendEmailVerification();

    await _userRepository
        .storeNewUser({'email': email, 'firstName': firstName, 'lastName': lastName, 'id': result.user.uid});

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

  Future<User> getUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.onAuthStateChanged.first;
    if (firebaseUser == null) return null;

    String uid = firebaseUser.uid;
    return await _userRepository.getUser(uid);
  }

  Future<void> forgotPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
