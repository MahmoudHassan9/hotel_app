import 'package:hotel_app/data/date_source_contract/register_data_source.dart';
import 'package:injectable/injectable.dart';

import '../api/firebase_services.dart';

@Injectable(as: RegisterDataSource)
class RegisterFirebaseDataSourceImpl extends RegisterDataSource {
  FirebaseServices firebaseServices;

  @factoryMethod
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
