import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/extensions/validate_ex.dart';
import 'package:hotel_app/core/utils/app_colors.dart';
import 'package:hotel_app/core/utils/app_styles.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/features/admin/presentation/screens/add_room_screen/viewModel/cubit/add_room_cubit.dart';
import 'package:hotel_app/features/admin/presentation/screens/add_room_screen/viewModel/state/add_room_state.dart';
import 'package:hotel_app/features/user/presentation/common/widgets/custom_button.dart';
import 'package:hotel_app/routing/router.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/utils/app_dialogs.dart';
import '../../../../../../routing/routes.dart';
import '../../../../../user/presentation/common/widgets/title_and_text_form_field.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  late TextEditingController roomTitleController;
  late TextEditingController roomDescriptionController;
  late TextEditingController roomPriceController;
  late TextEditingController roomNumberOfBedsController;
  late TextEditingController roomAreaController;
  late TextEditingController roomIDController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    roomTitleController = TextEditingController();
    roomDescriptionController = TextEditingController();
    roomPriceController = TextEditingController();
    roomNumberOfBedsController = TextEditingController();
    roomAreaController = TextEditingController();
    roomIDController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    roomTitleController.dispose();
    roomDescriptionController.dispose();
    roomPriceController.dispose();
    roomNumberOfBedsController.dispose();
    roomAreaController.dispose();
    roomIDController.dispose();
  }

  var cubit = getIt<AddRoomCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: Text(
          'Add Room',
          style: AppStyles.appBar,
        ),
      ),
      body: BlocProvider.value(
        value: cubit,
        child: BlocConsumer<AddRoomCubit, AddRoomState>(
          listener: (context, state) {
            switch (state) {
              case AddRoomInitialState():
              case AddRoomSuccessState():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.adminHome,
                  );
                  AppDialogs.showMessage(
                    context,
                    message: 'Added Successfully',
                    color: Colors.green,
                  );
                });
              case AddRoomErrorState():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  AppDialogs.showMessage(
                    context,
                    message: 'Error',
                    color: Colors.red,
                  );
                });
              case AddRoomLoadingState():
                Future.delayed(Duration.zero, () {
                  AppDialogs.showDialogWaiting(context);
                });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TitleAndTextFormField(
                        controller: roomTitleController,
                        title: 'Room Title',
                        hint: 'Enter room title',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'room title is required';
                          }
                          return null;
                        },
                      ),
                      TitleAndTextFormField(
                        controller: roomDescriptionController,
                        title: 'Room Description',
                        hint: 'Enter room description',
                        maxLines: 7,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'room description is required';
                          }
                          return null;
                        },
                      ),
                      TitleAndTextFormField(
                        controller: roomNumberOfBedsController,
                        title: 'Number Of Beds',
                        hint: 'Enter number of beds',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'number of beds is required';
                          }
                          return null;
                        },
                      ),
                      TitleAndTextFormField(
                        controller: roomPriceController,
                        title: 'Room Price',
                        hint: 'Enter room price',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'price is required';
                          }
                          return null;
                        },
                      ),
                      TitleAndTextFormField(
                        controller: roomAreaController,
                        title: 'Room Area',
                        hint: 'Enter room area',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'area is required';
                          }
                          return null;
                        },
                      ),
                      TitleAndTextFormField(
                        controller: roomIDController,
                        title: 'Room ID',
                        hint: 'Enter room ID',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'ID is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        width: double.maxFinite,
                        child: CustomButton(
                          text: 'Add To Explore List',
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            // log(roomTitleController.text);
                            cubit.addRoom(
                                'Explore List',
                                RoomDM(
                                  title: roomTitleController.text,
                                  image: '',
                                  description: roomDescriptionController.text,
                                  numberOfBeds: roomNumberOfBedsController.text,
                                  pricePerNight: roomPriceController.text,
                                  area: roomAreaController.text,
                                  listName: 'Explore List',
                                  id: roomIDController.text,
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        width: double.maxFinite,
                        child: CustomButton(
                          text: 'Add To MostPopular List',
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            cubit.addRoom(
                                'MostPopular List',
                                RoomDM(
                                  title: roomTitleController.text,
                                  image: '',
                                  description: roomDescriptionController.text,
                                  numberOfBeds: roomNumberOfBedsController.text,
                                  pricePerNight: roomPriceController.text,
                                  area: roomAreaController.text,
                                  listName: 'MostPopular List',
                                  id: roomIDController.text,
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
