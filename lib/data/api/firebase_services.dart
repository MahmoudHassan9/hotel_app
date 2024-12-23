import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:injectable/injectable.dart';

import '../../core/utils/constants.dart';
import '../../result.dart';
import '../models/user_model.dart';

@singleton
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
    DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(credential.user!.uid)
        .get();

    Map<String, dynamic> userJson =
        userDocumentSnapshot.data() as Map<String, dynamic>;
    userModel = UserDM.fromJson(userJson);
  }

  CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');

  Future<void> addRoom(String listName, RoomDM model) async {
    await adminCollection
        .doc('admin')
        .collection(listName)
        .doc(model.id)
        .set(model.toJson());
  }

  Future<void> deleteRoom(RoomDM model) async {
    await adminCollection
        .doc('admin')
        .collection(model.listName!)
        .doc(model.id)
        .delete();
  }

  Future<Result<List<RoomDM>>> getRoomsList(String listName) async {
    try {
      QuerySnapshot querySnapshot =
          await adminCollection.doc('admin').collection(listName).get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<RoomDM> roomList = [];
      roomList = docs.map((doc) {
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        return RoomDM.fromJson(json);
      }).toList();
      return Success(data: roomList);
    } on FirebaseException catch (e) {
      return ServerError(exception: e);
    } catch (e) {
      return Error(errorMessage: e.toString());
    }
  }

  Future<void> editRoom(RoomDM model) async {
    await adminCollection
        .doc('admin')
        .collection(model.listName!)
        .doc(model.id)
        .update(model.toJson());
  }

  Future<void> deleteUser(String uid) async {
    await usersCollection.doc(uid).delete();
  }

  Future<Result<List<UserDM>>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection.get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<UserDM> usersList = [];
      usersList = docs.map((doc) {
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        return UserDM.fromJson(json);
      }).toList();
      return Success(data: usersList);
    } on FirebaseException catch (e) {
      return ServerError(exception: e);
    } catch (e) {
      return Error(errorMessage: e.toString());
    }
  }

  Future<Result<UserDM>> getUser(id) async {
    try {
      DocumentSnapshot documentSnapshot = await usersCollection.doc(id).get();

      return Success(
        data: UserDM.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        ),
      );
    } on FirebaseException catch (e) {
      return ServerError(exception: e);
    } catch (e) {
      return Error(errorMessage: e.toString());
    }
  }

  Future<void> updateUser({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(email);
    await FirebaseAuth.instance.currentUser?.updateEmail(email);
    await FirebaseAuth.instance.currentUser?.updatePassword(password);
    await usersCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
      'email': email,
    });
  }

  Future<void> addRoomToBookingList(RoomDM model) async {
    await usersCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Booking List')
        .doc()
        .set(model.toJson());
  }

  Future<Result<List<RoomDM>>> getBookingList() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Booking List')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<RoomDM> roomList = [];
      roomList = docs.map((doc) {
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        return RoomDM.fromJson(json);
      }).toList();
      return Success(data: roomList);
    } on FirebaseException catch (e) {
      return ServerError(exception: e);
    } catch (e) {
      return Error(errorMessage: e.toString());
    }
  }
}
