import 'package:hotel_app/data/date_source_contract/user_data_source.dart';

import '../../data/models/user_model.dart';
import '../../result.dart';

abstract class UserRepo {
  Future<void> delete(String uid);

  Future<void> update({
    required String email,
    required String password,
  });

  Future<Result<List<UserDM>>> getUsers();

  Future<Result<UserDM>> getUser(id);
}
