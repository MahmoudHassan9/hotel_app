import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';
import 'package:hotel_app/data/datasource_impl/login_firebase_data_source_impl.dart';
import 'package:hotel_app/data/repo_impl/login_repo_impl.dart';
import 'package:hotel_app/domain/repo_contract/login_repo.dart';
import 'package:hotel_app/domain/usecases/login_use_case.dart';
import 'package:hotel_app/presentation/screens/auth/login/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_dialogs.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../data/api/firebase_services.dart';
import '../../../../../routing/routes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/title_and_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChangeNotifierProvider(
            create: (context) => LoginViewModel(
              useCase: LoginUseCase(
                repo: LoginRepoImpl(
                  loginDataSource: LoginFirebaseDataSourceImpl(
                    firebaseServices: FirebaseServices(),
                  ),
                ),
              ),
            ),
            child: Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                var state = viewModel.state;
                switch (state) {
                  case SuccessState():
                    Future.delayed(Duration.zero, () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.home,
                      );
                      AppDialogs.showMessage(
                        context,
                        message: 'logged in Successfully',
                        color: Colors.green,
                      );
                    });
                  case ErrorState():
                    Future.delayed(Duration.zero, () {
                      Navigator.pop(context);
                      AppDialogs.showMessage(
                        context,
                        message: state.exception != null
                            ? extractErrorMessage(state.exception!)
                            : state.errorMessage!,
                        color: Colors.red,
                      );
                    });
                  case LoadingState():
                    Future.delayed(Duration.zero, () {
                      AppDialogs.showDialogWaiting(context);
                    });
                  case InitialState():
                }
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome \n back !',
                          textAlign: TextAlign.center,
                          style: AppStyles.appBar.copyWith(
                            fontSize: 35,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TitleAndTextFormField(
                          fullNameController: emailController,
                          title: 'E-mail',
                          hint: 'Enter your email',
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'email is required';
                            } else if (!input.validate) {
                              return 'email should be formatted';
                            }
                            return null;
                          },
                        ),
                        TitleAndTextFormField(
                          fullNameController: passwordController,
                          isObscure: true,
                          title: 'Password',
                          hint: 'Enter your password',
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: CustomButton(
                            text: 'Login',
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;
                              viewModel.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account ?",
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              },
                              child: Text(
                                'Register',
                                style: AppStyles.settingsTabLabel.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String extractErrorMessage(FirebaseAuthException e) {
    late String message;
    if (e.code == 'invalid-credential') {
      message = 'email or password is incorrect \n'
          'try again';
    }
    return message;
  }
}
