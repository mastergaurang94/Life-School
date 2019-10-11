import 'package:lifeschool/auth/provider/auth_state_provider.dart';
import 'package:lifeschool/auth/provider/auth_state.dart';

class GetAuthRoute {
  final AuthStateProvider _authStateProvider;

  GetAuthRoute(this._authStateProvider);

  Future<String> getAuthRouteName() async {
    await _authStateProvider.refreshAuthState();
    final authState = await _authStateProvider.observeAuthState.first;
    String routeName;
    switch (authState.runtimeType) {
      case LoggedIn:
        routeName = "/explore";
        break;
      case LoggedOut:
        routeName = "/login";
        break;
      case MissingFields:
        routeName = "/onboarding/fields";
        break;
      case EmailNotVerified:
        routeName = "/onboarding/email";
        break;
    }

    return routeName;
  }
}
