import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';
import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/features/user/presentation/common/widgets/custom_button.dart';
import 'package:hotel_app/features/user/presentation/tabs/profile/viewModel/user_profile_cubit.dart';
import 'package:hotel_app/routing/routes.dart';

import '../../../../../../core/utils/app_dialogs.dart';
import '../../../common/widgets/title_and_text_form_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

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

  var cubit = getIt<UserProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          switch (state) {
            case UserProfileInitial():
            case UpdateUserProfileSuccess():
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
                AppDialogs.showMessage(
                  context,
                  message: 'Updated Successfully',
                  color: Colors.green,
                );
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.login,
                );
              });
            case UpdateUserProfileLoading():
              Future.delayed(Duration.zero, () {
                AppDialogs.showDialogWaiting(context);
              });
            case UpdateUserProfileError():
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
                AppDialogs.showMessage(
                  context,
                  message: 'Error',
                  color: Colors.red,
                );
              });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 24,
          ),
          child: Column(
            children: [
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomButton(
                  text: 'Update',
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      cubit.update(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  text: 'log out',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
