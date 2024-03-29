import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeschool/auth/provider/auth_state.dart';
import 'package:lifeschool/profile/repository/user_repository.dart';
import 'package:lifeschool/auth/provider/required_fields_provider.dart';
import 'package:rxdart/rxdart.dart';

class AuthStateProvider {
  final FirebaseAuth _firebaseAuth;
  final RequiredFieldsProvider _requiredFieldsProvider;
  final UserRepository _userRepository;

  AuthStateProvider(this._firebaseAuth, this._requiredFieldsProvider, this._userRepository);

  final BehaviorSubject<AuthState> _subject = BehaviorSubject();

  Observable<AuthState> get observeAuthState => _subject;

  Future<void> refreshAuthState() async {
    final state = await _getAuthState();
    _subject.add(state);
  }

  Future<AuthState> _getAuthState() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      return LoggedOut();
    }

    // Email verification requires "reloading" user to see.
    // Only bother with reload for this step or it takes too long.
    if (!currentUser.isEmailVerified && isAuthMechanismEmailPassword(currentUser)) {
      await currentUser.reload();
      currentUser = await _firebaseAuth.currentUser();
      if (!currentUser.isEmailVerified) {
        return EmailNotVerified();
      }
    }

//    final requiredFields = await _requiredFieldsProvider.requiredFields;
//    final missingFields = Set<String>();
//    await Future.forEach(requiredFields, (element) async {
//      final missingField = await _isFieldMissingForUser(currentUser.uid, element);
//      if (missingField) missingFields.add(element);
//    });
//
//    if (missingFields.isNotEmpty) return MissingFields(missingFields);

    return LoggedIn();
  }

  bool isAuthMechanismEmailPassword(FirebaseUser currentUser) {
    // TODO: This could break if Facebook changes their API for providerId == 'password'.
    return currentUser.providerData.any((UserInfo info) => info.providerId == 'password');
  }

  Future<bool> _isFieldMissingForUser(String userId, String requiredField) async {
    var existingValue;
    try {
      existingValue = await _userRepository.getPropertyForUser(userId, requiredField);
    } catch (e) {
      existingValue = null;
    }
    if (existingValue == null || existingValue == "") {
      return true;
    } else {
      return false;
    }
  }
}
