import 'package:lifeschool/auth/provider/current_token_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseCurrentTokenProvider implements CurrentTokenProvider {
  // TODO This ignore is probably bad
  // ignore: close_sinks
  final BehaviorSubject<String> _subject = BehaviorSubject();
  var hasStarted = false;

  @override
  Observable<String> observeAuthToken() {
    if (!hasStarted) {
      Observable(FirebaseAuth.instance.onAuthStateChanged)
          .flatMap((user) => user.getIdToken().asStream())
          .map((tokenIdResult) => tokenIdResult.token)
          .pipe(_subject);
      hasStarted = true;
    }
    return _subject;
  }
}
