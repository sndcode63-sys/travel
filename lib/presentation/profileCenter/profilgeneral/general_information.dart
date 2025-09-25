import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import '../../../utlis/formatters/validato.dart';
import 'general_information_controller.dart';

class GeneralInformation extends StatelessWidget {
  GeneralInformation({super.key});
  final GeneralInformationController controller = Get.put(
    GeneralInformationController(),
  );
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
                  icon: const Icon(Icons.account_circle_rounded, color: Colors.black54),
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
                    AppTextField(
                      hintText: "Full Name",
                      labelText: "Full Name",
                      showStar: true,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Full Name is required"
                                  : null,
                      onChanged: (val) => controller.fullName.value = val,
                    ),

                    // Father Name
                    AppTextField(
                      hintText: "Father Name",
                      labelText: "Father Name",
                      showStar: true,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Father Name is required"
                                  : null,
                      onChanged: (val) => controller.fatherName.value = val,
                    ),

                    // Mother Name
                    AppTextField(
                      hintText: "Mother Name",
                      labelText: "Mother Name",
                      onChanged: (val) => controller.motherName.value = val,
                    ),

                    // Spouse Name
                    AppTextField(
                      hintText: "Spouse Name",
                      labelText: "Spouse Name",
                      onChanged: (val) => controller.spouseName.value = val,
                    ),

                    // Email
                    AppTextField(
                      hintText: "Email Address",
                      labelText: "Email Address",
                      showStar: true,
                      validator: Validators.emailOrMobile,
                      onChanged: (val) => controller.email.value = val,
                    ),

                    // Contact Number
                    AppTextField(
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      hintText: "Contact Number",
                      labelText: "Contact Number",
                      showStar: true,
                      keyboardType: TextInputType.number,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Contact number is required"
                                  : null,
                      onChanged: (val) => controller.contactNumber.value = val,
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
                            items:
                                controller.days
                                    .map(
                                      (d) => DropdownMenuItem(
                                        value: d,
                                        child: Text(d.toString()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null)
                                controller.selectedDay.value = val;
                            },
                          ),
                          DropdownButton<int>(
                            value: controller.selectedMonth.value,
                            items:
                                controller.months
                                    .map(
                                      (m) => DropdownMenuItem(
                                        value: m,
                                        child: Text(m.toString()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null)
                                controller.selectedMonth.value = val;
                            },
                          ),
                          DropdownButton<int>(
                            value: controller.selectedYear.value,
                            items:
                                controller.years
                                    .map(
                                      (y) => DropdownMenuItem(
                                        value: y,
                                        child: Text(y.toString()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null)
                                controller.selectedYear.value = val;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Gender
                    AppTextField(
                      hintText: "Gender",
                      labelText: "Gender",
                      showStar: true,
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Gender is required"
                                  : null,
                      onChanged: (val) => controller.gender.value = val,
                    ),

                    // Nominee Name
                    AppTextField(
                      hintText: "Nominee Name",
                      labelText: "Nominee Name",
                      onChanged: (val) => controller.nomineeName.value = val,
                    ),

                    // Nominee Relation
                    AppTextField(
                      hintText: "Nominee Relation",
                      labelText: "Nominee Relation",
                      onChanged:
                          (val) => controller.nomineeRelation.value = val,
                    ),

                    const SizedBox(height: 24),

                    // Update Button
                    Obx(
                      () => CustomButton(
                        text: "UPDATE GENERAL INFORMATION",
                        backgroundColor:
                            controller.isFormValid
                                ? UColors.primary
                                : Colors.grey,
                        textColor: Colors.white,
                        onPressed:
                            controller.isFormValid
                                ? () {
                                  DateTime dob = controller.selectedDate;
                                  print(
                                    "Full Name: ${controller.fullName.value}",
                                  );
                                  print("DOB: $dob");
                                  print("Gender: ${controller.gender.value}");
                                  // Call API here
                                }
                                : null,
                      ),
                    ),
                    SizedBox(height: 30.h,),
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
