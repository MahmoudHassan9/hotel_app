import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/domain/usecases/get_user_use_case.dart';
import 'package:hotel_app/domain/usecases/update_user_use_case.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  @factoryMethod
  UserProfileCubit({required this.useCase}) : super(UserProfileInitial());
  UpdateUserUseCase useCase;

  void update({required String email, required String password}) async {
    try {
      emit(UpdateUserProfileLoading());
      await useCase.execute(email: email, password: password);
      emit(UpdateUserProfileSuccess());
    } catch (e) {
      log(e.toString());
      emit(UpdateUserProfileError());
    }
  }
}
