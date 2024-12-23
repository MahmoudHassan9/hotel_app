import 'package:hotel_app/data/models/room_model.dart';
import 'package:injectable/injectable.dart';

import '../repo_contract/room_repo.dart';

@injectable
class AddRoomUseCase {
  RoomRepo repo;

  @factoryMethod
  AddRoomUseCase({required this.repo});

  execute(RoomDM model, String listName) {
    return repo.addRoom(model, listName);
  }
}
