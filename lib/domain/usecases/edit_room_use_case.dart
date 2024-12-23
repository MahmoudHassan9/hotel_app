import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/repo_contract/room_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditRoomUseCase {
  RoomRepo repo;

  @factoryMethod
  EditRoomUseCase({required this.repo});

  executeEdit(RoomDM model) {
    return repo.editRoom(model);
  }

  executeDelete(RoomDM model) {
    return repo.deleteRoom(model);
  }
}
