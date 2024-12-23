import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/features/user/presentation/tabs/profile/viewModel/user_profile_cubit.dart';

import '../../tabs/booking/view/booking_view.dart';
import '../../tabs/home/view/home_view.dart';
import '../../tabs/profile/view/profile_view.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  List<Widget> tabs =  [
   const HomeView(),
    const BookingView(),
    BlocProvider(
      create: (context) => getIt<UserProfileCubit>(),
      child: const ProfileView(),
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() =>
      BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'HOME',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'BOOKING',
            icon: Icon(
              Icons.bookmark_added,
            ),
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
