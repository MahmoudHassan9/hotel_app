part of 'rooms_list_cubit.dart';

sealed class RoomsListState {}

final class RoomsListInitialState extends RoomsListState {}

final class RoomsListSuccessState extends RoomsListState {
}

final class RoomsListLoadingState extends RoomsListState {}

final class RoomsErrorState extends RoomsListState {
  FirebaseException? exception;
  String? errorMessage;
  RoomsErrorState({this.exception,this.errorMessage});
}
