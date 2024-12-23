import 'package:bloc/bloc.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/usecases/add_room_to_booking_list_use_case.dart';
import 'package:hotel_app/domain/usecases/get_booking_list_use_case.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

part 'booking_list_state.dart';

@injectable
class BookingListCubit extends Cubit<BookingListState> {
  @factoryMethod
  BookingListCubit({
    required this.addRoomToBookingListUseCase,
    required this.getBookingListUseCase,
  }) : super(AddToBookingListInitial());
  AddRoomToBookingListUseCase addRoomToBookingListUseCase;
  GetBookingListUseCase getBookingListUseCase;

  void addRoomTOBookingList(RoomDM model) async {
    try {
      emit(AddToBookingListLoading());
      await addRoomToBookingListUseCase.execute(model);
      emit(AddToBookingListSuccess());
      getBookingList();
    } catch (e) {
      emit(AddToBookingListError());
    }
  }

  void getBookingList() async {
    var result = await getBookingListUseCase.execute();
    switch (result) {
      case Success<List<RoomDM>>():
        emit(GetBookingListSuccess(list: result.data));
      case ServerError<List<RoomDM>>():
        emit(GetBookingListError());
      case Error<List<RoomDM>>():
        emit(GetBookingListError());
    }
  }
}
