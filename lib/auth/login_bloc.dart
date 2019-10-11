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
  BehaviorSubject<String> errorMessage = BehaviorSubject();

  // ignore: close_sinks
  BehaviorSubject<bool> resetEmailSent = BehaviorSubject.seeded(false);

  // ignore: close_sinks
  BehaviorSubject<LoginState> loginState = BehaviorSubject.seeded(LoginState.IDLE);

  void handleLoginPressed(BuildContext context, String email, String password) async {
    loginState.add(LoginState.LOADING);

    try {
      await _authRepository.signInWithCredentials(email, password);
      loginState.add(LoginState.SUCCESS);
      final route = await _getAuthRoute.getAuthRouteName();
      Navigator.pushReplacementNamed(context, route);
    } catch (e) {
      errorMessage.add(e.toString());
      loginState.add(LoginState.IDLE);
    }
  }

  void handleSignUpPressed(BuildContext context, String email, String password, String confirmedPassword,
      String firstName, String lastName) async {
    loginState.add(LoginState.LOADING);

    try {
      await _authRepository.signUp(email, password);

      loginState.add(LoginState.SUCCESS);
      final route = await _getAuthRoute.getAuthRouteName();
      Navigator.of(context).pushNamed(route);
    } catch (e) {
      errorMessage.add(e.toString());
      loginState.add(LoginState.IDLE);
    }
  }

  void handleForgotPasswordPressed(BuildContext context, String email) async {
    if (validateEmail(email) != null) {
      errorMessage.add(validateEmail(email));
    } else {
      loginState.add(LoginState.LOADING);
      await _authRepository.forgotPassword(email);
      errorMessage.add("");
      resetEmailSent.add(true);
      loginState.add(LoginState.IDLE);
    }
  }

  void handleDeleteUser() async {
    try {
      await _authRepository.deleteUser();
    } catch (e) {
      errorMessage.add(e.toString());
    }

    loginState.add(LoginState.IDLE);
  }

  // TODO: adjust return to user object
  Future<String> getUser() async {
    return await _authRepository.getUser();
  }

  void sendEmailVerification() async {
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
