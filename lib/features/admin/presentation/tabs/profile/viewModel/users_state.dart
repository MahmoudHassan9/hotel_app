part of 'users_cubit.dart';

 class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccess extends UsersState {
  List<UserDM> users;

  UsersSuccess({required this.users});
}

final class UsersError extends UsersState {}


final class DeleteUserLoading extends UsersState {}

final class DeleteUserSuccess extends UsersState {

}

final class DeleteUserError extends UsersState {}
