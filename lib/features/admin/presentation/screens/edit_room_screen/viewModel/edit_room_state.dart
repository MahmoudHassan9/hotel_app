part of 'edit_room_cubit.dart';

sealed class EditRoomState {}

final class EditRoomInitial extends EditRoomState {}

final class EditRoomLoading extends EditRoomState {}

final class EditRoomSuccess extends EditRoomState {}

final class EditRoomError extends EditRoomState {}

final class DeleteRoomLoading extends EditRoomState {}

final class DeleteRoomSuccess extends EditRoomState {}

final class DeleteRoomError extends EditRoomState {}
