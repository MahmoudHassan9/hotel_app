import 'package:hotel_app/domain/repo_contract/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginRepo repo;

  @factoryMethod
  LoginUseCase({required this.repo});

  execute(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
