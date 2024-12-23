import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/domain/repo_contract/user_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteUserUseCase {
  UserRepo repo;

  @factoryMethod
  DeleteUserUseCase({required this.repo});

  execute(String uid) {
    return repo.delete(uid);
  }
}
