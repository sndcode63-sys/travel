import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';

class AddMemberInfoScreen extends StatelessWidget {
  const AddMemberInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMemberInfoController());
    final args = Get.arguments as Map<String, dynamic>?;
    final schemeId = args?['id'] ?? '';
    final schemeName = args?['name'] ?? '';

    print('➡ Received Scheme -> ID: $schemeId, Name: $schemeName');


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(70.h),
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
                        icon: const Icon(Icons.arrow_back,),
                        onPressed: () => Get.back(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            "Add Visit",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Add Client Information",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings,),
                    onPressed: () {
                      Get.toNamed(AppRoutes.addClientInformation);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child:  Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h,),
                          /// Show location status
                          Obx(() {
                            if (controller.currentPosition.value == null) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Location is disabled or not detected.\nPlease enable location to continue.",
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            } else {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Location Detected: \nLat: ${controller.currentPosition.value!.latitude}, "
                                      "Lng: ${controller.currentPosition.value!.longitude}",
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    color: Colors.green,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }
                          }),

                          SizedBox(height: 20.h,),
                          CustomButton(
                            text: "SCHEME: $schemeName",
                            backgroundColor: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            borderRadius: 15,
                            fontSize: 16.sp,
                            height: 50.h,
                          ),
                          SizedBox(height: 20.h,),

                          /// Client Name
                          AppTextField(
                            controller: controller.clientName,
                            hintText: "Client Name",
                            keyboardType: TextInputType.name,

                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Client Name required";
                              }
                              if (!RegExp(r"^[a-zA-Z ]{3,}$").hasMatch(val.trim())) {
                                return "Only alphabets, min 3 characters";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h,),
                          AppTextField(

                            controller: controller.fatherName,
                            hintText: "Father/Spouse Name",
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Father/Spouse Name required";
                              }
                              if (!RegExp(r"^[a-zA-Z ]{3,}$").hasMatch(val.trim())) {
                                return "Only alphabets, min 3 characters";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h,),
                          AppTextField(

                            controller: controller.email,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Email required";
                              }
                              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                  .hasMatch(val.trim())) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h,),
                          AppTextField(
                            controller: controller.contactNo,
                            hintText: "Contact No.",
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return "Contact No. required";
                              if (!RegExp(r"^[0-9]{10}$").hasMatch(val.trim())) return "Enter 10 digit number";
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h,),
                          AppTextField(

                            controller: controller.remark,
                            hintText: "Remark (Optional)",
                            maxLines: 1,
                            validator: (val) {
                              if (val != null && val.length > 200) {
                                return "Remark cannot exceed 200 chars";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 100.h,),
                          /// CONTINUE Button
                          CustomButton(
                            backgroundColor: UColors.primary,
                            text: "CONTINUE",
                            onPressed: () {

                              if (controller.formKey.currentState!.validate()) {
                                final schemeArgs = Get.arguments as Map<String, dynamic>?;

                                final args = {
                                  'clientName': controller.clientName.text.trim(),
                                  'fatherName': controller.fatherName.text.trim(),
                                  'email': controller.email.text.trim(),
                                  'contactNo': controller.contactNo.text.trim(),
                                  'remark': controller.remark.text.trim(),
                                  'schemeName': schemeArgs?['id'] ?? '',
                                  'lat': controller.currentPosition.value?.latitude.toString(),
                                  'lng': controller.currentPosition.value?.longitude.toString(),
                                };

                                print("➡ Sending data to AddClientInformationScreen: $args");

                                Get.toNamed(AppRoutes.addClientInformation, arguments: args);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

        )

      ),
    );
  }

  Widget addMemberTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
