import 'package:hotel_app/domain/repo_contract/room_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/room_model.dart';
import '../../result.dart';

@injectable
class GetBookingListUseCase {
  RoomRepo repo;

  @factoryMethod
  GetBookingListUseCase({required this.repo});

  Future<Result<List<RoomDM>>> execute() {
    return repo.getBookingList();
  }
}
