import 'package:firebase_auth/firebase_auth.dart';

sealed class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  FirebaseAuthException? exception;
  String? errorMessage;

  LoginErrorState({
    this.exception,
    this.errorMessage,
  });
}
