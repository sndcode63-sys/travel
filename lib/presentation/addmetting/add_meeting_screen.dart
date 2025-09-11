import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:travell_booking_app/presentation/addmetting/widgets/add_meeting_widgets.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';
import '../../utlis/constents/color_constants.dart';

class AddMeetingScreen extends StatelessWidget {
  const AddMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back Button + Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Add Meeting",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Meeting List",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Settings Icon
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.black54),
                    onPressed: () {
                      // Action here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  20.h,
                  addMeetingWidgets.addMeetingTextFormField(
                    hintText: 'Number Of Users',
                    labelText: 'Number Of Users',
                  ),
                  20.h,
                  addMeetingWidgets.addMeetingTextFormField(
                    hintText: 'Reference',
                    labelText: 'Reference',
                  ),
                  30.h,
                  DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 1,
                    dashPattern: const [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: Container(
                      height: 310,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, color: Colors.grey),
                            8.h,
                            addMeetingWidgets.buildText(
                              "Click or Upload Selfie here",
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  30.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addMeetingWidgets.buildText("Capture Visit Image"),
                      addMeetingWidgets.buildText("Capture Visit Image"),
                    ],
                  ),
                  25.h,
                  CustomButton(
                    text: 'SAVE',
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
