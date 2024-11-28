import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/presentation/screens/auth/login/view/login_view.dart';
import 'package:hotel_app/presentation/screens/auth/register/view/register_view.dart';
import 'package:hotel_app/routing/routes.dart';

abstract class AppRouter {
  static Route? router(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
    }
    return null;
  }
}
