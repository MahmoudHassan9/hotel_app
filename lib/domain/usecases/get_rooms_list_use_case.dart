import 'package:hotel_app/domain/repo_contract/room_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/room_model.dart';
import '../../result.dart';

@injectable
class GetRoomsListUseCase {
  RoomRepo repo;

  @factoryMethod
  GetRoomsListUseCase({required this.repo});

  Future<Result<List<RoomDM>>> execute(String listName) {
    return repo.getRooms(listName);
  }
}
