import 'package:lifeschool/auth/usecase/auth_repository.dart';
import 'package:lifeschool/auth/usecase/get_auth_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final AuthRepository _authRepository;
  final GetAuthRoute _getAuthRoute;

  LoginBloc(this._authRepository, this._getAuthRoute);

  // ignore: close_sinks
  BehaviorSubject<LoginState> loginState = BehaviorSubject.seeded(LoginState.IDLE);

  Future<void> handleLoginPressed(BuildContext context, String email, String password) async {
    loginState.add(LoginState.LOADING);

    try {
      await _authRepository.signInWithCredentials(email, password);
      loginState.add(LoginState.SUCCESS);
      final route = await _getAuthRoute.getAuthRouteName();
      Navigator.pushReplacementNamed(context, route);
    } catch (e) {
      loginState.add(LoginState.IDLE);
      throw e;
    }
  }

  Future<void> handleSignUpPressed(BuildContext context, String email, String password, String confirmedPassword,
      String firstName, String lastName) async {
    loginState.add(LoginState.LOADING);

    try {
      await _authRepository.signUp(email, password);

      loginState.add(LoginState.SUCCESS);
      final route = await _getAuthRoute.getAuthRouteName();
      Navigator.of(context).pushNamed(route);
    } catch (e) {
      loginState.add(LoginState.IDLE);
      throw e;
    }
  }

  Future<void> handleGoogleLoginPressed(BuildContext context) async {
    loginState.add(LoginState.LOADING);
    await _authRepository.signInWithGoogle();
    loginState.add(LoginState.SUCCESS);
    final route = await _getAuthRoute.getAuthRouteName();
    Navigator.pushReplacementNamed(context, route);
  }

  Future<void> handleFacebookLoginPressed(BuildContext context) async {
    loginState.add(LoginState.LOADING);
    await _authRepository.loginWithFacebook();
    loginState.add(LoginState.SUCCESS);
    final route = await _getAuthRoute.getAuthRouteName();
    Navigator.pushReplacementNamed(context, route);
  }

  Future<void> handleForgotPasswordPressed(BuildContext context, String email) async {
    loginState.add(LoginState.LOADING);
    await _authRepository.forgotPassword(email);
    loginState.add(LoginState.IDLE);
  }

  Future<void> handleDeleteUser() async {
    await _authRepository.deleteUser();
    loginState.add(LoginState.IDLE);
  }

  // TODO: adjust return to user object
  Future<String> getUser() async {
    return await _authRepository.getUser();
  }

  Future<void> sendEmailVerification() async {
    await _authRepository.sendEmailVerification();
  }

  String validatePassword(String password) {
    final RegExp _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (password == null || password.isEmpty || !_passwordRegExp.hasMatch(password)) return 'Not a valid password.';

    return null;
  }

  String validateConfirmPassword(String confirmedPassword, String password) {
    if (confirmedPassword != password) {
      return 'Your passwords do not match.';
    }

    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    if (!EmailValidator.validate(value)) {
      return 'Not a valid email.';
    }
    return null;
  }

  String validateName(String name) {
    if (name == null || name.isEmpty) return 'Name is required.';

    return null;
  }
}

enum LoginState { IDLE, FAILURE, LOADING, SUCCESS }
