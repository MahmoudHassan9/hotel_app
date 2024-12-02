import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/domain/usecases/login_use_case.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({required this.useCase}) : super(state: InitialState());

  LoginUseCase useCase;

  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingState());
      await useCase.execute(email, password);
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(exception: e));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
