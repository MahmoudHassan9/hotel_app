import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

abstract class AppDialogs {
  static void showMessage(context,
          {required String message, required Color color}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.settingsTabLabel.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
          backgroundColor: color,
          dismissDirection: DismissDirection.horizontal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        ),
      );

  static void showDialogWaiting(context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
          title: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  static void removeDialog(context) => Navigator.pop(context);
}
