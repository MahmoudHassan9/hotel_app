import 'package:firebase_auth/firebase_auth.dart';

sealed class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  FirebaseAuthException? exception;
  String? errorMessage;

  RegisterErrorState({this.exception, this.errorMessage});
}
