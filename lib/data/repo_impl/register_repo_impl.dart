import 'package:hotel_app/data/date_source_contract/register_data_source.dart';
import 'package:hotel_app/domain/repo_contract/register_repo.dart';

class RegisterRepoImpl extends RegisterRepo {
  RegisterDataSource registerDataSource;

  RegisterRepoImpl({required this.registerDataSource});

  @override
  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber}) {
    return registerDataSource.register(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
