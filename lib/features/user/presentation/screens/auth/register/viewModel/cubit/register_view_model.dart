import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/domain/usecases/register_use_case.dart';
import 'package:injectable/injectable.dart';

import '../state/register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  @factoryMethod
  RegisterViewModel({required this.useCase}) : super(RegisterInitialState());
  RegisterUseCase useCase;

  void register({
    required context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      emit(RegisterLoadingState());
      await useCase.execute(email, password, name, phoneNumber);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(exception: e));
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}
