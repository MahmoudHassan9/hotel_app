import 'package:hotel_app/data/date_source_contract/user_data_source.dart';
import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/domain/repo_contract/user_repo.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepo)
class UserRepoImpl extends UserRepo {
  UserDataSource dataSource;

  @factoryMethod
  UserRepoImpl({required this.dataSource});

  @override
  Future<void> delete(String uid) async {
    return dataSource.delete(uid);
  }

  @override
  Future<Result<List<UserDM>>> getUsers() async {
    var result = await dataSource.getUsers();
    switch (result) {
      case Success<List<UserDM>>():
        return Success(data: result.data);
      case ServerError<List<UserDM>>():
        return ServerError(exception: result.exception);
      case Error<List<UserDM>>():
        return Error(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<UserDM>> getUser(id) async {
    var result = await dataSource.getUser(id);
    switch (result) {
      case Success<UserDM>():
        return Success(data: result.data);
      case ServerError<UserDM>():
        return ServerError(exception: result.exception);
      case Error<UserDM>():
        return Error(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<void> update({required String email, required String password}) {
    return dataSource.update(email: email, password: password);
  }
}
