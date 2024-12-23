import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

import '../date_source_contract/room_data_source.dart';

@Injectable(as: RoomDataSource)
class AddRoomFirebaseDataSourceImpl extends RoomDataSource {
  FirebaseServices firebaseServices;

  @factoryMethod
  AddRoomFirebaseDataSourceImpl({required this.firebaseServices});

  @override
  Future<void> addRoom(RoomDM model, String listName) {
    return firebaseServices.addRoom(listName, model);
  }

  @override
  Future<Result<List<RoomDM>>> getRooms(String listName) {
    return firebaseServices.getRoomsList(listName);
  }

  @override
  Future<void> editRoom(RoomDM model) {
    return firebaseServices.editRoom(model);
  }

  @override
  Future<void> addRoomToBookingList(RoomDM model) {
    return firebaseServices.addRoomToBookingList(model);
  }

  @override
  Future<Result<List<RoomDM>>> getBookingList() {
    return firebaseServices.getBookingList();
  }

  @override
  Future<void> deleteRoom(RoomDM model) {
    return firebaseServices.deleteRoom(model);
  }
}
