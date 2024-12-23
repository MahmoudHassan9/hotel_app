import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/features/admin/presentation/tabs/profile/view/admin_profile_view.dart';
import 'package:hotel_app/features/admin/presentation/tabs/profile/viewModel/users_cubit.dart';
import 'package:hotel_app/features/admin/presentation/tabs/rooms/view/rooms_view.dart';
import 'package:hotel_app/routing/routes.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Widget> tabs = [
    const RoomsView(),
    BlocProvider.value(
      value: getIt<UsersCubit>(),
      child: const AdminProfileView(),
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.adminAddRoom,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() => BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'ROOMS',
            icon: Icon(Icons.bed),
          ),
          BottomNavigationBarItem(
            label: 'PROFILE',
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      );
}
