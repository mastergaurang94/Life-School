import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

class LoggedIn extends AuthState {
  @override
  String toString() => 'Logged In';
}

class LoggedOut extends AuthState {
  @override
  String toString() => 'Logged Out';
}

class EmailNotVerified extends AuthState {
  @override
  String toString() => 'Email Not Verified';
}

class MissingFields extends AuthState {
  final Set<String> missingFields;

  MissingFields(this.missingFields);

  @override
  String toString() => 'Missing Fields';
}
