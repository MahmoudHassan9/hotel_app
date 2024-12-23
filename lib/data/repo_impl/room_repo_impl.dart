import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/domain/repo_contract/room_repo.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

import '../date_source_contract/room_data_source.dart';

@Injectable(as: RoomRepo)
class AddRoomRepoImpl extends RoomRepo {
  RoomDataSource dataSource;

  @factoryMethod
  AddRoomRepoImpl({required this.dataSource});

  @override
  Future<void> addRoom(RoomDM model, String listName) {
    return dataSource.addRoom(model, listName);
  }

  @override
  Future<Result<List<RoomDM>>> getRooms(String listName) async {
    var result = await dataSource.getRooms(listName);
    switch (result) {
      case Success<List<RoomDM>>():
        return Success(data: result.data);
      case ServerError<List<RoomDM>>():
        return ServerError(exception: result.exception);
      case Error<List<RoomDM>>():
        return Error(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<void> editRoom(RoomDM model) {
    return dataSource.editRoom(model);
  }

  @override
  Future<void> addRoomToBookingList(RoomDM model) {
    return dataSource.addRoomToBookingList(model);
  }

  @override
  Future<Result<List<RoomDM>>> getBookingList() async {
    var result = await dataSource.getBookingList();
    switch (result) {
      case Success<List<RoomDM>>():
        return Success(data: result.data);
      case ServerError<List<RoomDM>>():
        return ServerError(exception: result.exception);
      case Error<List<RoomDM>>():
        return Error(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<void> deleteRoom(RoomDM model) {
    return dataSource.deleteRoom(model);
  }
}
