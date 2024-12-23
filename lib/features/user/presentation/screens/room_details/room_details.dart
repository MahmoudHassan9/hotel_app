import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/utils/app_colors.dart';
import 'package:hotel_app/core/utils/app_styles.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/features/user/presentation/common/widgets/custom_button.dart';
import 'package:hotel_app/features/user/presentation/tabs/booking/viewModel/booking_list_cubit.dart';

import '../../../../../core/utils/app_dialogs.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../routing/routes.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({super.key, required this.model});

  final RoomDM model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        title: Text(
          model.title ?? '',
          style: AppStyles.appBar,
        ),
      ),
      body: BlocListener<BookingListCubit, BookingListState>(
        listener: (context, state) {
          if (state is AddToBookingListSuccess) {
            Future.delayed(Duration.zero, () {
              AppDialogs.showMessage(
                context,
                message: 'Added to bookingList Successfully',
                color: Colors.green,
              );
            });
          } else if (state is AddToBookingListError) {
            Future.delayed(Duration.zero, () {
              AppDialogs.showMessage(
                context,
                message: 'Error',
                color: Colors.red,
              );
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppConstants.roomImage,
              height: 300,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  featureItem(
                    Icons.bed,
                    model.numberOfBeds ?? '',
                  ),
                  featureItem(
                    Icons.tv,
                    '',
                  ),
                  featureItem(
                    Icons.bathtub,
                    '',
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                model.description ?? '',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  Widget bottomNavBar(context) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.blue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            Text(
              '\$ ${model.pricePerNight} /night' ?? '',
              style: AppStyles.settingsTabLabel,
            ),
            const Spacer(),
            CustomButton(
              text: 'Book Now',
              onPressed: () {
                BlocProvider.of<BookingListCubit>(context)
                    .addRoomTOBookingList(model);
              },
            ),
          ],
        ),
      );

  Widget featureItem(IconData icon, String text) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.blue.withOpacity(0.4),
        ),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
      );
}
