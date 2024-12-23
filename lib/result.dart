import 'package:cloud_firestore/cloud_firestore.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  T data;

  Success({required this.data});
}

class ServerError<T> extends Result<T> {
  FirebaseException exception;

  ServerError({required this.exception});
}

class Error<T> extends Result<T> {
  String errorMessage;

  Error({required this.errorMessage});
}
