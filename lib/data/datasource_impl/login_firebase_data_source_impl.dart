import 'package:hotel_app/data/date_source_contract/login_data_source.dart';

import '../api/firebase_services.dart';

class LoginFirebaseDataSourceImpl extends LoginDataSource {
  FirebaseServices firebaseServices;

  LoginFirebaseDataSourceImpl({required this.firebaseServices});

  @override
  Future<void> login({required String email, required String password}) {
    return firebaseServices.login(email: email, password: password);
  }
}
