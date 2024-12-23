import 'package:bloc/bloc.dart';
import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/domain/usecases/delete_user_use_case.dart';
import 'package:hotel_app/domain/usecases/get_users_use_case.dart';
import 'package:hotel_app/result.dart';
import 'package:injectable/injectable.dart';

part 'users_state.dart';

@injectable
class UsersCubit extends Cubit<UsersState> {
  @factoryMethod
  UsersCubit({
    required this.useCase,
    required this.deleteUserUseCase,
  }) : super(UsersInitial());
  GetUsersUseCase useCase;
  DeleteUserUseCase deleteUserUseCase;

  void getUsers() async {
    var result = await useCase.execute();
    switch (result) {
      case Success<List<UserDM>>():
        emit(UsersSuccess(users: result.data));
      case ServerError<List<UserDM>>():
        emit(UsersError());
      case Error<List<UserDM>>():
        emit(UsersError());
    }
  }

  void deleteUser(String uid) async {
    try {
      emit(DeleteUserLoading());
      await deleteUserUseCase.execute(uid);
      emit(DeleteUserSuccess());
      getUsers();
    } on Exception catch (e) {
      emit(DeleteUserError());
    }
  }
}
