import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/data/api/firebase_services.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel() : super(state: InitialState());

  void register({
    required context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      emit(LoadingState());
      await FirebaseServices.register(
        context,
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(exception: e));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
