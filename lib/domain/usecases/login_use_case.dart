import 'package:hotel_app/domain/repo_contract/login_repo.dart';

class LoginUseCase {
  LoginRepo repo;

  LoginUseCase({required this.repo});

  execute(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
