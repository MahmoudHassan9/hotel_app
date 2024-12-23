import 'package:bloc/bloc.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/usecases/edit_room_use_case.dart';
import 'package:injectable/injectable.dart';

part 'edit_room_state.dart';

@injectable
class EditRoomCubit extends Cubit<EditRoomState> {
  @factoryMethod
  EditRoomCubit({required this.useCase}) : super(EditRoomInitial());
  EditRoomUseCase useCase;

  void editRoom(RoomDM model) async {
    try {
      emit(EditRoomLoading());
      await useCase.executeEdit(model);
      emit(EditRoomSuccess());
    } on Exception catch (e) {
      emit(EditRoomError());
    }
  }

  void deleteRoom(RoomDM model) async {
    try {
      emit(DeleteRoomLoading());
      await useCase.executeDelete(model);
      emit(DeleteRoomSuccess());
    } on Exception catch (e) {
      emit(DeleteRoomError());
    }
  }
}
