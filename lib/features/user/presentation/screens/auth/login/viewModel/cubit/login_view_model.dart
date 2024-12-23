import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/core/utils/constants.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/domain/usecases/login_use_case.dart';
import 'package:hotel_app/features/user/presentation/screens/auth/login/viewModel/states/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  @factoryMethod
  LoginViewModel({required this.useCase}) : super(LoginInitialState());

  LoginUseCase useCase;

  bool isAdmin(email, password) =>
      email == AppConstants.adminEmail &&
      password == AppConstants.adminPassword;

  void login({
    required String email,
    required String password,
  }) async {
    try {
      log(isAdmin(email, password).toString());
      emit(LoginLoadingState());
      if (isAdmin(email, password)) {
        emit(AdminLoginSuccessState());
      } else {
        await useCase.execute(email, password);
        emit(LoginSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(exception: e));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
