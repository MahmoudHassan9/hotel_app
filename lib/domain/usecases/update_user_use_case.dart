import 'package:hotel_app/domain/repo_contract/user_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserUseCase {
  UserRepo repo;

  @factoryMethod
  UpdateUserUseCase({required this.repo});

  execute({required String email, required String password}) {
    return repo.update(email: email, password: password);
  }
}
