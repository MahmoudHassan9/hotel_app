import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
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
          ),
        ),
      ),
    );
  }
}
