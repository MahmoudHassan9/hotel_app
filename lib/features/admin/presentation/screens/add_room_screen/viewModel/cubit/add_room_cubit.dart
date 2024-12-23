import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/usecases/add_room_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../state/add_room_state.dart';

@injectable
class AddRoomCubit extends Cubit<AddRoomState> {
  @factoryMethod
  AddRoomCubit({required this.useCase}) : super(AddRoomInitialState());
  AddRoomUseCase useCase;

  Future<void> addRoom(String listName, RoomDM model) async {
    try {
      emit(AddRoomLoadingState());
      await useCase.execute(model, listName);
      emit(AddRoomSuccessState());
    } on FirebaseException catch (e) {
      emit(AddRoomErrorState(exception: e));
    } catch (e) {
      emit(AddRoomErrorState(errorMessage: e.toString()));
    }
  }
}
