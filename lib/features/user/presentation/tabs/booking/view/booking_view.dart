import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/utils/app_colors.dart';
import 'package:hotel_app/core/utils/app_styles.dart';
import 'package:hotel_app/core/utils/constants.dart';
import 'package:hotel_app/features/user/presentation/tabs/booking/viewModel/booking_list_cubit.dart';
import 'package:hotel_app/routing/routes.dart';

import '../../../../../../data/models/room_model.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BookingListCubit>(context).getBookingList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListCubit, BookingListState>(
      builder: (context, state) {
        if (state is GetBookingListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetBookingListError) {
          return Text('Error');
        } else if (state is GetBookingListSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 24,
                ),
                child: Text(
                  'Booking List',
                  style: AppStyles.settingsTabLabel.copyWith(
                    fontSize: 30,
                    color: AppColors.blue,
                  ),
                ),
              ),
              Expanded(
                child: bookingList(state.list),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget bookingList(list) => ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.roomDetails,
                arguments: list[index]);
          },
          child: bookingListItem(
            list[index],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(
          thickness: 2,
          endIndent: 15,
          indent: 15,
          height: 25,
        ),
        itemCount: list.length,
      );

  Widget bookingListItem(RoomDM model) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                AppConstants.roomImage,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? '',
                    style: AppStyles.settingsTabLabel,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '\$ ${model.pricePerNight}' ?? '',
                      style: AppStyles.settingsTabLabel.copyWith(
                        fontSize: 13,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
