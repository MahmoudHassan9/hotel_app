import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/domain/usecases/register_use_case.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel({required this.useCase}) : super(state: InitialState());
  RegisterUseCase useCase;

  void register({
    required context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      emit(LoadingState());
      await useCase.execute(email, password, name, phoneNumber);
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(exception: e));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
