import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/admin/presentation/screens/add_room_screen/view/add_room_screen.dart';
import 'package:hotel_app/features/admin/presentation/screens/admin_home_Screen/admin_home_screen.dart';
import 'package:hotel_app/features/admin/presentation/screens/edit_room_screen/view/edit_room.dart';
import 'package:hotel_app/features/user/presentation/screens/room_details/room_details.dart';
import 'package:hotel_app/routing/routes.dart';

import '../data/models/room_model.dart';
import '../features/user/presentation/screens/auth/login/view/login_view.dart';
import '../features/user/presentation/screens/auth/register/view/register_view.dart';
import '../features/user/presentation/screens/home_screen/home_screen.dart';

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

      case AppRoutes.userHome:
        return MaterialPageRoute(
          builder: (context) => const UserHomeScreen(),
        );

      case AppRoutes.adminHome:
        return MaterialPageRoute(
          builder: (context) => const AdminHomeScreen(),
        );

      case AppRoutes.adminAddRoom:
        return MaterialPageRoute(
          builder: (context) => const AddRoomScreen(),
        );

      case AppRoutes.editRoom:
        return MaterialPageRoute(builder: (context) {
          var model = routeSettings.arguments as RoomDM;
          return EditRoom(model: model);
        });

      case AppRoutes.roomDetails:
        return MaterialPageRoute(builder: (context) {
          var model = routeSettings.arguments as RoomDM;
          return RoomDetails(model: model);
        });
    }
    return null;
  }
}
