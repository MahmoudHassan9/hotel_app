import 'package:hotel_app/data/date_source_contract/login_data_source.dart';
import 'package:hotel_app/data/date_source_contract/register_data_source.dart';

import '../api/firebase_services.dart';

class RegisterFirebaseDataSourceImpl extends RegisterDataSource {
  FirebaseServices firebaseServices;

  RegisterFirebaseDataSourceImpl({required this.firebaseServices});

  @override
  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber}) {
    return firebaseServices.register(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
