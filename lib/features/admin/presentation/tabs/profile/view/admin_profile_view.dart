import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/core/utils/app_colors.dart';
import 'package:hotel_app/core/utils/app_styles.dart';
import 'package:hotel_app/data/models/user_model.dart';
import 'package:hotel_app/features/admin/presentation/tabs/profile/viewModel/users_cubit.dart';
import 'package:hotel_app/features/user/presentation/common/widgets/custom_button.dart';
import 'package:hotel_app/routing/routes.dart';

import '../../../../../../core/utils/app_dialogs.dart';

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({super.key});

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UsersCubit>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is DeleteUserSuccess) {
          Future.delayed(Duration.zero, () {
            Navigator.pop(context);
            AppDialogs.showMessage(
              context,
              message: 'Deleted Successfully',
              color: Colors.green,
            );
          });
        } else if (state is DeleteUserLoading) {
          Future.delayed(Duration.zero, () {
            AppDialogs.showDialogWaiting(context);
          });
        }
      },
      builder: (context, state) {
        switch (state) {
          case UsersInitial():
          case UsersLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case UsersSuccess():
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Users',
                    style: AppStyles.settingsTabLabel.copyWith(
                      fontSize: 40,
                      color: AppColors.blue,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => listTileItem(
                        state.users[index],
                      ),
                      itemCount: state.users.length,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      text: 'Log out',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          case UsersError():
            return const Text('Error');
        }
        return const SizedBox();
      },
    );
  }

  Widget listTileItem(UserDM model) => ListTile(
        title: Text(
          model.name!,
          style: AppStyles.settingsTabLabel,
        ),
        subtitle: Text(model.email!),
        trailing: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(0.2),
          ),
          child: IconButton(
              onPressed: () {
                BlocProvider.of<UsersCubit>(context).deleteUser(model.uid!);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ),
      );
}
