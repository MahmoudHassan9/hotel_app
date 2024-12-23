import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/result.dart';

abstract class RoomDataSource {
  Future<void> addRoom(
    RoomDM model,
    String listName,
  );

  Future<void> editRoom(
    RoomDM model,
  );

  Future<void> deleteRoom(
    RoomDM model,
  );

  Future<Result<List<RoomDM>>> getRooms(String listName);

  Future<Result<List<RoomDM>>> getBookingList();

  Future<void> addRoomToBookingList(RoomDM model);
}
