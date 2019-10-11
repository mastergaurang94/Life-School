import 'package:rxdart/rxdart.dart';

abstract class CurrentTokenProvider {
  Observable<String> observeAuthToken();
}
