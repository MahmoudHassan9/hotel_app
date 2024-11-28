import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/base/base_viewModel/base_view_model.dart';
import 'package:hotel_app/data/api/firebase_services.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel() : super(state: InitialState());

  void login({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingState());
      await FirebaseServices.login(
        context,
        email: email,
        password: password,
      );
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(exception: e));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
