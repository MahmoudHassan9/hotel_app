import 'package:hotel_app/domain/repo_contract/register_repo.dart';

class RegisterUseCase {
  RegisterRepo repo;

  RegisterUseCase({required this.repo});

  execute(
    String email,
    String password,
    String name,
    String phoneNumber,
  ) {
    return repo.register(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
