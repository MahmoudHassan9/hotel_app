import 'package:hotel_app/domain/repo_contract/user_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../../result.dart';

@injectable
class GetUsersUseCase {
  UserRepo repo;

  @factoryMethod
  GetUsersUseCase({required this.repo});

  Future<Result<List<UserDM>>> execute() {
    return repo.getUsers();
  }
}
