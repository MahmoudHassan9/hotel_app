import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/base/base_state/base_state.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';
import 'package:hotel_app/core/utils/app_dialogs.dart';
import 'package:hotel_app/data/api/firebase_services.dart';
import 'package:hotel_app/data/datasource_impl/register_firebase_data_source_impl.dart';
import 'package:hotel_app/data/repo_impl/register_repo_impl.dart';
import 'package:hotel_app/domain/usecases/register_use_case.dart';
import 'package:hotel_app/features/user/presentation/screens/auth/register/viewModel/state/register_state.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/constants.dart';
import '../../../../../../../routing/routes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/title_and_text_form_field.dart';
import '../viewModel/cubit/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  var cubit = getIt<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider.value(
            value: cubit,
            child: BlocConsumer<RegisterViewModel, RegisterState>(
              listener: (context, state) {
                switch (state) {
                  case RegisterInitialState():
                  case RegisterLoadingState():
                    Future.delayed(Duration.zero, () {
                      AppDialogs.showDialogWaiting(context);
                    });
                  case RegisterSuccessState():
                    Future.delayed(Duration.zero, () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
                      );
                      AppDialogs.showMessage(
                        context,
                        message: 'Registered Successfully',
                        color: Colors.green,
                      );
                    });
                  case RegisterErrorState():
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
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Delta Dahab \n Hotel',
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
                          controller: fullNameController,
                          title: 'Full Name',
                          hint: 'Enter your full name',
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'name is required';
                            }
                            return null;
                          },
                        ),
                        TitleAndTextFormField(
                          controller: phoneNumberController,
                          title: 'Phone Number',
                          hint: 'Enter your Number',
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'phone number is required';
                            }
                            return null;
                          },
                        ),
                        TitleAndTextFormField(
                          controller: emailController,
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
                          controller: passwordController,
                          title: 'Password',
                          hint: 'Enter your password',
                          isObscure: true,
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                        ),
                        TitleAndTextFormField(
                          controller: confirmPasswordController,
                          title: 'Confirm Password',
                          hint: 'Confirm password',
                          isObscure: true,
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return 'confirm password is required';
                            } else if (passwordController.text != input) {
                              return "password doesn't match";
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
                            text: 'Register',
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;
                              cubit.register(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                                name: fullNameController.text,
                                phoneNumber: phoneNumberController.text,
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Do you have an account ?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: Text(
                                'Login',
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
    if (e.code == AppConstants.weakPass) {
      message = 'The password provided is too weak';
    } else if (e.code == AppConstants.emailInUse) {
      message = 'The account already exists for that email';
    } else if (e.code == AppConstants.invalidEmail) {
      message = 'The Email addresse is badly formated';
    } else {
      message = e.toString();
    }
    return message;
  }
}
