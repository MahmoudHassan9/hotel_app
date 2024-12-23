import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/repo_contract/room_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddRoomToBookingListUseCase {
  RoomRepo repo;

  @factoryMethod
  AddRoomToBookingListUseCase({required this.repo});

  execute(RoomDM model) {
    return repo.addRoomToBookingList(model);
  }
}
