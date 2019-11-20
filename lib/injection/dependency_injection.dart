import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/auth/provider/auth_state_provider.dart';
import 'package:lifeschool/auth/usecase/auth_repository.dart';
import 'package:lifeschool/auth/usecase/get_auth_route.dart';
import 'package:lifeschool/services/user/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Future<SharedPreferences> get sharedPreferencesFuture {
    return SharedPreferences.getInstance();
  }

  /// AUTH START
  FirebaseAuth get firebaseAuth {
    return FirebaseAuth.instance;
  }

  Firestore get firestore {
    return Firestore.instance;
  }

  FirebaseStorage get firebaseStorage {
    return FirebaseStorage.instance;
  }

  GoogleSignIn get googleSignIn {
    return GoogleSignIn();
  }

  FacebookLogin get facebookLogin {
    return FacebookLogin();
  }

  AuthStateProvider _authStateProviderSingleton;

  AuthStateProvider get authStateProvider {
    if (_authStateProviderSingleton == null) {
      _authStateProviderSingleton = AuthStateProvider(firebaseAuth, userRepository);
    }
    return _authStateProviderSingleton;
  }

  var _userRepositorySingleton;

  UserRepository get userRepository {
    if (_userRepositorySingleton == null) {
      _userRepositorySingleton = UserRepository(firestore);
    }
    return _userRepositorySingleton;
  }

  var _authRepositorySingleton;

  AuthRepository get authRepository {
    if (_authRepositorySingleton == null) {
      _authRepositorySingleton = AuthRepository(firebaseAuth, googleSignIn, facebookLogin, userRepository);
    }

    return _authRepositorySingleton;
  }

  GetAuthRoute get getAuthRoute => GetAuthRoute(authStateProvider);

  var _loginBloc;

  LoginBloc get loginBloc {
    if (_loginBloc == null) {
      _loginBloc = LoginBloc(authRepository, getAuthRoute);
    }
    return _loginBloc;
  }

/// AUTH END
}
