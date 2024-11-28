import 'package:flutter/cupertino.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import 'custom_text_form_field.dart';

class TitleAndTextFormField extends StatelessWidget {
  const TitleAndTextFormField({
    super.key,
    required this.fullNameController,
    required this.title,
    required this.hint,
    this.validator,
    this.isObscure = false,
  });

  final TextEditingController fullNameController;
  final String title;
  final String hint;
  final String? Function(String?)? validator;
  final bool isObscure;

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
          controller: fullNameController,
          validator: validator,
          obscureText: isObscure,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
