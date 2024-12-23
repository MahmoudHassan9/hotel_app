import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/di/di.dart';
import 'package:hotel_app/core/utils/constants.dart';
import 'package:hotel_app/data/models/room_model.dart';
import 'package:hotel_app/features/admin/presentation/screens/edit_room_screen/viewModel/edit_room_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_dialogs.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../routing/routes.dart';
import '../../../../../user/presentation/common/widgets/custom_button.dart';
import '../../../../../user/presentation/common/widgets/title_and_text_form_field.dart';

class EditRoom extends StatefulWidget {
  const EditRoom({super.key, required this.model});

  final RoomDM model;

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  late TextEditingController roomTitleController;
  late TextEditingController roomDescriptionController;
  late TextEditingController roomPriceController;
  late TextEditingController roomNumberOfBedsController;
  late TextEditingController roomAreaController;
  late TextEditingController roomIDController;

  @override
  void initState() {
    super.initState();
    roomTitleController = TextEditingController();
    roomTitleController.text = widget.model.title ?? '';
    roomDescriptionController = TextEditingController();
    roomDescriptionController.text = widget.model.description ?? '';
    roomPriceController = TextEditingController();
    roomPriceController.text = widget.model.pricePerNight ?? '';
    roomNumberOfBedsController = TextEditingController();
    roomNumberOfBedsController.text = widget.model.numberOfBeds ?? '';
    roomAreaController = TextEditingController();
    roomAreaController.text = widget.model.area ?? '';
    roomIDController = TextEditingController();
    roomIDController.text = widget.model.id ?? '';
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

  var cubit = getIt<EditRoomCubit>();

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
          'Edit Room',
          style: AppStyles.appBar,
        ),
      ),
      body: BlocProvider.value(
        value: cubit,
        child: BlocListener<EditRoomCubit, EditRoomState>(
          listener: (context, state) {
            switch (state) {
              case EditRoomInitial():
              case EditRoomLoading():
                Future.delayed(Duration.zero, () {
                  AppDialogs.showDialogWaiting(context);
                });
              case EditRoomSuccess():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.adminHome,
                  );
                  AppDialogs.showMessage(
                    context,
                    message: 'Updated Successfully',
                    color: Colors.green,
                  );
                });
              case EditRoomError():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  AppDialogs.showMessage(
                    context,
                    message: 'Error',
                    color: Colors.red,
                  );
                });
              case DeleteRoomLoading():
                Future.delayed(Duration.zero, () {
                  AppDialogs.showDialogWaiting(context);
                });
              case DeleteRoomSuccess():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.adminHome,
                  );
                  AppDialogs.showMessage(
                    context,
                    message: 'Deleted Successfully',
                    color: Colors.green,
                  );
                });
              case DeleteRoomError():
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  AppDialogs.showMessage(
                    context,
                    message: 'Error',
                    color: Colors.red,
                  );
                });
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                  const SizedBox(
                    height: 20,
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
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Update',
                          onPressed: () {
                            cubit.editRoom(
                              RoomDM(
                                id: roomIDController.text,
                                listName: widget.model.listName,
                                area: roomAreaController.text,
                                pricePerNight: roomPriceController.text,
                                numberOfBeds: roomNumberOfBedsController.text,
                                description: roomDescriptionController.text,
                                title: roomTitleController.text,
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          text: 'delete',
                          color: Colors.red,
                          onPressed: () {
                            cubit.deleteRoom(widget.model);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
