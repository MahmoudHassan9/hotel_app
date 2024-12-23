import '../../data/models/room_model.dart';
import '../../result.dart';

abstract class RoomRepo {
  Future<void> addRoom(
    RoomDM model,
    String listName,
  );

  Future<void> deleteRoom(RoomDM model);

  Future<Result<List<RoomDM>>> getRooms(String listName);

  Future<Result<List<RoomDM>>> getBookingList();

  Future<void> editRoom(
    RoomDM model,
  );

  Future<void> addRoomToBookingList(RoomDM model);
}
