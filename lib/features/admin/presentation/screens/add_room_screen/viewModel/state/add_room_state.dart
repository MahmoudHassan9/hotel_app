import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

sealed class AddRoomState {}

class AddRoomInitialState extends AddRoomState {}

class AddRoomSuccessState extends AddRoomState {}

class AddRoomErrorState extends AddRoomState {
  FirebaseException? exception;
  String? errorMessage;

  AddRoomErrorState({
    this.exception,
    this.errorMessage,
  });
}

class AddRoomLoadingState extends AddRoomState {}
