part of 'user_profile_cubit.dart';

sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UpdateUserProfileSuccess extends UserProfileState {}

final class UpdateUserProfileLoading extends UserProfileState {}

final class UpdateUserProfileError extends UserProfileState {}
