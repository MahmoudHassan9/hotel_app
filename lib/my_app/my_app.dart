import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/features/admin/presentation/tabs/rooms/viewModel/rooms_list_cubit.dart';
import 'package:hotel_app/features/user/presentation/tabs/booking/viewModel/booking_list_cubit.dart';
import 'package:hotel_app/routing/router.dart';
import 'package:hotel_app/routing/routes.dart';

import '../config/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<RoomsListCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<BookingListCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRouter.router,
        initialRoute: AppRoutes.adminHome,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
