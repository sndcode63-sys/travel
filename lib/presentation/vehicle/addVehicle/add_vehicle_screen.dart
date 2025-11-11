import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/vehicle/addVehicle/add_vehicle_controller.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import '../../profileCenter/profileInfo/profile_info_screen.dart';


class AddVehicleScreen extends GetView<AddVehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.only(top: 8.h,bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        "Add Vehicle",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: 16.h),

                CustomDropDownField(
                  labelText: "Vehicle Type",
                  hintText: "Select Vehicle Type",
                  controller: controller.vehicleTypeController,
                  items: controller.vehicleTypes,
                  selectedValue: controller.selectedVehicleType,
                  onChanged: controller.onVehicleTypeChanged,
                ),
                SizedBox(height: 8.h),

                Obx(() => CustomDropDownField(
                  labelText: "Brand",
                  hintText: "Select Brand",
                  controller: controller.brandControllerDropdown,
                  items: controller.brandList
                      .map((brand) => DropDownValueModel(
                    name: brand.name ?? "",
                    value: brand.name ?? "",
                  ))
                      .toList(),
                  selectedValue: controller.selectedBrand,
                )),

                AppTextField(
                  controller: controller.registrationController,
                  hintText: "Registration Number",
                  labelText: "Registration Number",
                  showStar: true,
                ),
                SizedBox(height: 16.h),

                // Model
                AppTextField(
                  controller: controller.modelController,
                  hintText: "Model Name",
                  labelText: "Model Name",
                  showStar: true,
                ),
                SizedBox(height: 16.h),

                // Color
                AppTextField(
                  controller: controller.colorController,
                  hintText: "Vehicle Color",
                  labelText: "Vehicle Color",
                  showStar: true,
                ),
                SizedBox(height: 16.h),

                // Open Camera Button
                CustomButton(
                  text: "Open Camera",
                  backgroundColor: UColors.primary,
                  textColor: UColors.white,
                  width: 210.w,
                  onPressed: () => controller.openCamera(),
                ),
                SizedBox(height: 16.h),

                // Captured Image Preview
                Obx(() => DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 1,
                  dashPattern: const [6, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => controller.openCamera(),
                    child: Container(
                      height: 310.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: controller.capturedImage.value == null
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: UColors.primary, size: 40.sp),
                            SizedBox(height: 8.h),
                            Text(
                              "Tap to capture vehicle image",
                              style: TextStyle(
                                  color: UColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          controller.capturedImage.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                )),

                SizedBox(height: 16.h),

                // Save Button
                CustomButton(
                  text: "Add Vehicle",
                  backgroundColor: Colors.green,
                  textColor: UColors.white,
                  onPressed: () => controller.saveForm(),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> items;
  final Rx<DropDownValueModel?> selectedValue;
  final Function(DropDownValueModel?)? onChanged;

  const CustomDropDownField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.items,
    required this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 6),
        DropDownTextField(
          controller: controller,
          clearOption: true,
          enableSearch: true,
          dropDownList: items,
          dropDownItemCount: items.length,
          textFieldDecoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
          ),
          onChanged: (val) {
            selectedValue.value = val;
            if (onChanged != null) onChanged!(val);
          },
        ),
      ],
    );
  }
}
