import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import 'custom_text_form_field.dart';

class TitleAndTextFormField extends StatelessWidget {
  const TitleAndTextFormField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hint,
      this.validator,
      this.isObscure = false,
      this.maxLines});

  final TextEditingController controller;
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final bool isObscure;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.settingsTabLabel.copyWith(
            color: AppColors.blue,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextFormField(
          hintText: hint,
          controller: controller,
          validator: validator,
          obscureText: isObscure,
          maxLines: maxLines ?? 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
