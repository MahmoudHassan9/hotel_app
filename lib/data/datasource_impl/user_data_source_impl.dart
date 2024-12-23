import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/data/models/user_model.dart';

import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

import '../date_source_contract/user_data_source.dart';

@Injectable(as: UserDataSource)
class DeleteUserDataSourceImpl extends UserDataSource {
  FirebaseServices firebaseServices;

  @factoryMethod
  DeleteUserDataSourceImpl({required this.firebaseServices});

  @override
  Future<void> delete(String uid) {
    return firebaseServices.deleteUser(uid);
  }

  @override
  Future<Result<List<UserDM>>> getUsers() {
    return firebaseServices.getUsers();
  }

  @override
  Future<Result<UserDM>> getUser(id) {
    return firebaseServices.getUser(id);
  }

  @override
  Future<void> update({required String email, required String password}) {
    return firebaseServices.updateUser(
      email: email,
      password: password,
    );
  }
}
