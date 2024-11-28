import 'package:firebase_auth/firebase_auth.dart';

sealed class BaseState<T> {}

class SuccessState<T> extends BaseState<T> {}

class InitialState<T> extends BaseState<T> {}

class ErrorState<T> extends BaseState<T> {
  FirebaseAuthException? exception;
  String? errorMessage;

  ErrorState({
    this.exception,
    this.errorMessage,
  });
}

class LoadingState<T> extends BaseState<T> {
  String? loadingMessage;

  LoadingState({
    this.loadingMessage,
  });
}
