import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import 'general_information_controller.dart';

class GeneralInformation extends StatelessWidget {
  GeneralInformation({super.key});
  final GeneralInformationController controller =
  Get.put(GeneralInformationController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "General Information",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded,
                      color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: UColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    // Full Name
                    AppTextField(
                      controller: controller.fullNameController,
                      hintText: "Full Name",
                      labelText: "Full Name",
                      showStar: true,
                      validator: (val) => val == null || val.isEmpty ? "Full Name is required" : null,
                    ),

// Father Name
                    AppTextField(
                      controller: controller.fatherNameController,
                      hintText: "Father Name",
                      labelText: "Father Name",
                      showStar: true,
                      validator: (val) => val == null || val.isEmpty ? "Father Name is required" : null,
                    ),

// Email
                    AppTextField(
                      controller: controller.emailController,
                      hintText: "Email Address",
                      labelText: "Email Address",
                      showStar: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Email is required";
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                        if (!emailRegex.hasMatch(val)) return "Enter a valid email";
                        return null;
                      },
                    ),

// Contact Number
                    AppTextField(
                      controller: controller.contactNumberController,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      hintText: "Contact Number",
                      labelText: "Contact Number",
                      showStar: true,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Contact number is required";
                        if (val.length != 10) return "Contact number must be 10 digits";
                        return null;
                      },
                    ),

// Gender
                    AppTextField(
                      controller: controller.genderController,
                      hintText: "Gender",
                      labelText: "Gender",
                      showStar: true,
                      validator: (val) => val == null || val.isEmpty ? "Gender is required" : null,
                    ),


                    const SizedBox(height: 16),

                    // DOB Label
                    Row(
                      children: const [
                        Text(
                          "Date of Birth",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text("*", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // DOB Dropdowns
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<int>(
                            value: controller.selectedDay.value,
                            items: controller.days
                                .map((d) => DropdownMenuItem(
                              value: d,
                              child: Text(d.toString()),
                            ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) controller.selectedDay.value = val;
                            },
                          ),
                          DropdownButton<int>(
                            value: controller.selectedMonth.value,
                            items: controller.months
                                .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(m.toString()),
                            ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) controller.selectedMonth.value = val;
                            },
                          ),
                          DropdownButton<int>(
                            value: controller.selectedYear.value,
                            items: controller.years
                                .map((y) => DropdownMenuItem(
                              value: y,
                              child: Text(y.toString()),
                            ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) controller.selectedYear.value = val;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Gender
                    AppTextField(
                      controller: controller.genderController,
                      hintText: "Gender",
                      labelText: "Gender",
                      showStar: true,
                      validator: (val) =>
                      val == null || val.isEmpty ? "Gender is required" : null,
                    ),

                    // Nominee Name
                    AppTextField(
                      controller: controller.nomineeNameController,
                      hintText: "Nominee Name",
                      labelText: "Nominee Name",
                    ),

                    // Nominee Relation
                    AppTextField(
                      controller: controller.nomineeRelationController,
                      hintText: "Nominee Relation",
                      labelText: "Nominee Relation",
                    ),

                    const SizedBox(height: 24),


                    Obx(
                          () => CustomButton(
                        text: controller.isLoading.value ? "UPDATING..." : "UPDATE GENERAL INFORMATION",
                        backgroundColor: controller.isFormValid.value ? UColors.primary : Colors.grey,
                        textColor: Colors.white,
                        onPressed: controller.isFormValid.value && !controller.isLoading.value
                            ? () => controller.saveGeneralInfo(_formKey)
                            : null,
                      ),
                    ),

                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
