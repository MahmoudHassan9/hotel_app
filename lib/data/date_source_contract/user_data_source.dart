import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/result.dart';

abstract class UserDataSource {
  Future<void> delete(String uid);

  Future<void> update({
    required String email,
    required String password,
  });

  Future<Result<List<UserDM>>> getUsers();

  Future<Result<UserDM>> getUser(id);
}
