import 'package:flutter/material.dart';
import 'package:hotel_app/core/utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: Colors.blue,
    ),
  );
}
