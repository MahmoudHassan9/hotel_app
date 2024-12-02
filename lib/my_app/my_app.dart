import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/routing/router.dart';
import 'package:hotel_app/routing/routes.dart';

import '../config/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.router,
      initialRoute: AppRoutes.register,
      debugShowCheckedModeBanner: false,
    );
  }
}
