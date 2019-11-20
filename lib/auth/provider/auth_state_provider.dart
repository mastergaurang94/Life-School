import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifeschool/auth/provider/auth_state.dart';
import 'package:lifeschool/services/user/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthStateProvider {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthStateProvider(this._firebaseAuth, this._userRepository);

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

    // TODO: Add required fields to sign up

    return LoggedIn();
  }

  bool isAuthMechanismEmailPassword(FirebaseUser currentUser) {
    // TODO: This could break if Facebook changes their API for providerId == 'password'.
    return currentUser.providerData.any((UserInfo info) => info.providerId == 'password');
  }
}
