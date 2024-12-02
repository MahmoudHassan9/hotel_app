import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/constants.dart';
import '../models/user_model.dart';

class FirebaseServices {
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(UserDM.collectionName);

  static late UserDM userModel;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userModel = UserDM(
      email: email,
      uid: credential.user!.uid,
      name: name,
      phoneNumber: phoneNumber,
    );
    DocumentReference usersDocuments = usersCollection.doc(userModel.uid);
    usersDocuments.set(userModel.toJson());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    DocumentSnapshot userDoucumentSnapshot = await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(credential.user!.uid)
        .get();

    Map<String, dynamic> userJson =
        userDoucumentSnapshot.data() as Map<String, dynamic>;
    userModel = UserDM.fromJson(userJson);
  }
}
