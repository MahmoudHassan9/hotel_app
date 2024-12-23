part of 'booking_list_cubit.dart';

sealed class BookingListState {}

final class AddToBookingListInitial extends BookingListState {}

final class AddToBookingListLoading extends BookingListState {}

final class AddToBookingListSuccess extends BookingListState {}

final class AddToBookingListError extends BookingListState {}

final class GetBookingListInitial extends BookingListState {}

final class GetBookingListLoading extends BookingListState {}

final class GetBookingListSuccess extends BookingListState {
  List<RoomDM> list;

  GetBookingListSuccess({required this.list});
}

final class GetBookingListError extends BookingListState {
}
