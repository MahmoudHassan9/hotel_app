import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/admin/presentation/tabs/rooms/viewModel/rooms_list_cubit.dart';
import 'package:hotel_app/routing/routes.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../data/models/room_model.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<RoomsListCubit>(context).getRoomsList('Explore List');
    BlocProvider.of<RoomsListCubit>(context).getRoomsList('MostPopular List');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsListCubit, RoomsListState>(
      builder: (context, state) {
        switch (state) {
          case RoomsListInitialState():
          case RoomsListSuccessState():
            return Padding(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Explore List Rooms',
                      style: AppStyles.settingsTabLabel.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  exploreList(
                    BlocProvider.of<RoomsListCubit>(context).exploreList,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Most Popular List Rooms ',
                      style: AppStyles.settingsTabLabel.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  mostPopularList(
                    BlocProvider.of<RoomsListCubit>(context).mostPopularList,
                  ),
                ],
              ),
            );
          case RoomsListLoadingState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RoomsErrorState():
            return Center(
              child: Text(state.exception != null
                  ? state.exception.toString()
                  : state.errorMessage!),
            );
        }
      },
    );
  }

  Widget mostPopularListItem({required RoomDM model}) => Container(
        width: 250,
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 175,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppConstants.roomImage,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    model.title ?? '',
                    style: AppStyles.settingsTabLabel.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '\$${model.pricePerNight!}/night' ?? '',
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget mostPopularList(list) => Expanded(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editRoom,
                arguments: list[index],
              );
            },
            child: mostPopularListItem(model: list[index]),
          ),
          itemCount: list.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
        ),
      );

  Widget exploreList(list) => SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editRoom,
                arguments: list[index],
              );
            },
            child: exploreListItem(
              model: list[index],
            ),
          ),
          itemCount: list.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
        ),
      );

  Widget exploreListItem({required RoomDM model}) => Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppConstants.roomImage,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    model.title ?? '',
                    style: AppStyles.settingsTabLabel.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '\$${model.pricePerNight!}/night' ?? '',
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
