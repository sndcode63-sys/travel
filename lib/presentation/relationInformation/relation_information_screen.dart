import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import '../profileCenter/profileInfo/profile_info_screen.dart';
import 'relation_information_controller.dart';

class RelationInformationScreen extends StatelessWidget {
  const RelationInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RelationInformationController controller = Get.put(RelationInformationController());

    return GestureDetector(
      onTap: (){
        hideKeyboard();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Relation Information',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black54,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SizedBox.expand(
          child: Container(
            color: Colors.blue.withOpacity(0.08),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    CustomDropDownField(
                      labelText: "",
                      hintText: "Select Rera Serial",
                      controller: controller.selectedR,
                      items: const [
                        DropDownValueModel(name: 'Option 1', value: "Option 1"),
                        DropDownValueModel(name: 'Option 2', value: "Option 2"),
                        DropDownValueModel(name: 'Option 3', value: "Option 3"),
                      ],
                      selectedValue: controller.selectedRera,
                    ),
                    AppTextField(hintText: "Rera Number", labelText: "Rera Number"),
                    AppTextField(hintText: "Team Name", labelText: "Team Name"),
                    AppTextField(hintText: "Pin Name", labelText: "Pin Name"),
                    AppTextField(
                      hintText: "Location Name",
                      labelText: "Location Name",
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: BottomAppBar(
          child: CustomButton(text: "UPDATE", backgroundColor: UColors.primary),
        ),
      ),
    );
  }
}
