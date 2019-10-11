import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/auth/provider/required_fields_provider.dart';
import 'package:lifeschool/auth/provider/auth_state_provider.dart';
import 'package:lifeschool/auth/usecase/auth_repository.dart';
import 'package:lifeschool/auth/usecase/get_auth_route.dart';
import 'package:lifeschool/data/firebase_base_repository.dart';
import 'package:lifeschool/profile/repository/user_repository.dart';
import 'package:lifeschool/profile/repository/firebase_user_repository.dart';
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

  FirebaseDatabase get firebaseDatabase {
    return FirebaseDatabase.instance;
  }

  FirebaseStorage get firebaseStorage {
    return FirebaseStorage.instance;
  }

  GoogleSignIn get googleSignIn {
    return GoogleSignIn();
  }

  var _firebaseBaseRepository;

  FirebaseBaseRepository get firebaseBaseRepository {
    if (_firebaseBaseRepository == null) {
      _firebaseBaseRepository = FirebaseBaseRepository(firebaseDatabase);
    }
    return _firebaseBaseRepository;
  }

  RequiredFieldsProvider _requiredFieldsProviderSingleton;

  RequiredFieldsProvider get requiredFieldsProvider {
    if (_requiredFieldsProviderSingleton == null) {
      _requiredFieldsProviderSingleton = RequiredFieldsProvider(firebaseBaseRepository);
    }
    return _requiredFieldsProviderSingleton;
  }

  AuthStateProvider _authStateProviderSingleton;

  AuthStateProvider get authStateProvider {
    if (_authStateProviderSingleton == null) {
      _authStateProviderSingleton = AuthStateProvider(firebaseAuth, requiredFieldsProvider, userRepository);
    }
    return _authStateProviderSingleton;
  }

  var _userRepositorySingleton;

  UserRepository get userRepository {
    if (_userRepositorySingleton == null) {
      _userRepositorySingleton = FirebaseUserRepository(firebaseBaseRepository);
    }
    return _userRepositorySingleton;
  }

  var _authRepositorySingleton;

  AuthRepository get authRepository {
    if (_authRepositorySingleton == null) {
      _authRepositorySingleton = AuthRepository(firebaseAuth, googleSignIn);
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
