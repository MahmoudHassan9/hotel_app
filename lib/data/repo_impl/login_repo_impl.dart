import 'package:hotel_app/data/date_source_contract/login_data_source.dart';
import 'package:hotel_app/domain/repo_contract/login_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl extends LoginRepo {
  LoginDataSource loginDataSource;

  @factoryMethod
  LoginRepoImpl({required this.loginDataSource});

  @override
  Future<void> login({required String email, required String password}) {
    return loginDataSource.login(email: email, password: password);
  }
}
