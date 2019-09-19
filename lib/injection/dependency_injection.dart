import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lifeschool/auth/provider/required_fields_provider.dart';
import 'package:lifeschool/auth/provider/auth_state_provider.dart';
import 'package:lifeschool/data/firebase_base_repository.dart';
import 'package:lifeschool/user/repository/user_repository.dart';
import 'package:lifeschool/user/repository/firebase_user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  FirebaseAuth get firebaseAuth {
    return FirebaseAuth.instance;
  }

  FirebaseDatabase get firebaseDatabase {
    return FirebaseDatabase.instance;
  }

  FirebaseStorage get firebaseStorage {
    return FirebaseStorage.instance;
  }

  Future<SharedPreferences> get sharedPreferencesFuture {
    return SharedPreferences.getInstance();
  }

  var _firebaseBaseRepository;

  FirebaseBaseRepository get callTimeRepository {
    if (_firebaseBaseRepository == null) {
      _firebaseBaseRepository = FirebaseBaseRepository(firebaseDatabase);
    }
    return _firebaseBaseRepository;
  }

  RequiredFieldsProvider _requiredFieldsProviderSingleton;

  RequiredFieldsProvider get requiredFieldsProvider {
    if (_requiredFieldsProviderSingleton == null) {
      _requiredFieldsProviderSingleton = RequiredFieldsProvider(_firebaseBaseRepository);
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
      _userRepositorySingleton = FirebaseUserRepository(_firebaseBaseRepository);
    }
    return _userRepositorySingleton;
  }
}
