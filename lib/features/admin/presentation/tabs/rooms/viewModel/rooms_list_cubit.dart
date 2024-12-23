import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/usecases/get_rooms_list_use_case.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

part 'rooms_list_state.dart';

@injectable
class RoomsListCubit extends Cubit<RoomsListState> {
  @factoryMethod
  RoomsListCubit({required this.useCase}) : super(RoomsListInitialState());
  GetRoomsListUseCase useCase;
  List<RoomDM> exploreList = [];
  List<RoomDM> mostPopularList = [];

  void getRoomsList(String listName) async {
    emit(RoomsListLoadingState());
    var result = await useCase.execute(listName);
    switch (result) {
      case Success<List<RoomDM>>():
        {
          if (listName == 'Explore List') {
            exploreList = result.data;
          } else {
            mostPopularList = result.data;
          }
          emit(RoomsListSuccessState());
        }
      case ServerError<List<RoomDM>>():
        emit(RoomsErrorState(exception: result.exception));
      case Error<List<RoomDM>>():
        emit(RoomsErrorState(errorMessage: result.errorMessage));
    }
  }
}
