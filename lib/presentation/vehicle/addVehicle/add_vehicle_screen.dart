import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/vehicle/addVehicle/add_vehicle_controller.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import '../../complaine/coplainDisputeSummary/enter_summary_screen.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              CustomDropDownField(
                labelText: "Dispute Reason",
                hintText: "Select Dispute Reason",
                controller: controller.vehicleType,
                items: const [
                  DropDownValueModel(name: 'Plot', value: 'Plot'),
                  DropDownValueModel(name: 'Other', value: 'Other'),
                ],
                selectedValue: controller.vehicleController,
              ),
              SizedBox(height: 16.h),
              CustomDropDownField(
                labelText: "Dispute Reason",
                hintText: "Select Dispute Reason",
                controller: controller.vehicleType,
                items: const [
                  DropDownValueModel(name: 'Plot', value: 'Plot'),
                  DropDownValueModel(name: 'Other', value: 'Other'),
                ],
                selectedValue: controller.vehicleController,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: "Brand Name",
                labelText: "Brand Name",
                showStar: true,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                hintText: "Model Name",
                labelText: "Model Name",
                showStar: true,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                hintText: "Vehicle Color",
                labelText: "Vehicle Color",
                showStar: true,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                text: "Open Camera",
                backgroundColor: UColors.primary,
                textColor: UColors.white,
                width: 210.w,
                onPressed: () {
                  controller.openCamera();
                },
              ),
              SizedBox(height: 16.h),
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
                          Icon(Icons.camera_alt, color: UColors.primary, size: 40.sp),
                          SizedBox(height: 8.h),
                          Text("Tap to capture selfie", style: TextStyle(color: UColors.primary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(controller.capturedImage.value!, fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                ),
              )),

              SizedBox(height: 16.h),
              CustomButton(
                text: "Add Vehicle",
                backgroundColor: Colors.green,
                textColor: UColors.white,
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
