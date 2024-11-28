import 'package:flutter/material.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../routing/routes.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/title_and_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                    fullNameController: fullNameController,
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
                    fullNameController: phoneNumberController,
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
                    fullNameController: confirmPasswordController,
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
          ),
        ),
      ),
    );
  }
}
