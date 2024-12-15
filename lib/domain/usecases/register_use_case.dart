import 'package:hotel_app/domain/repo_contract/register_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  RegisterRepo repo;

  @factoryMethod
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
