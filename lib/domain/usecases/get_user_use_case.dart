import 'package:hotel_app/domain/repo_contract/user_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../../result.dart';

@injectable
class GetUserUseCase {
  UserRepo repo;

  @factoryMethod
  GetUserUseCase({required this.repo});

  Future<Result<UserDM>> execute(id) {
    return repo.getUser(id);
  }
}
