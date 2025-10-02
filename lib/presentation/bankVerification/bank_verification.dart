import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import '../../utlis/constents/colors.dart';
import '../profileCenter/profileInfo/profile_info_screen.dart';
import 'bank_verification_controller.dart';

class BankVerification extends StatelessWidget {
  BankVerification({super.key});

  final controller = Get.put(BankVerificationController());

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
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: SafeArea(
            child: Row(
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
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bank Info',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SizedBox.expand(
          child: Container(
            color: Colors.blue.withOpacity(0.08),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // IFSC
                    AppTextField(
                      controller: controller.ifscController,
                      hintText: "IFSC Code",
                      labelText: "IFSC Code",
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter IFSC Code" : null,
                      onChanged: (value) {
                        if (value.length == 11) {
                          controller.fetchBankInfoByIfsc(value);
                        }
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Bank Name (read-only)
                    AppTextField(
                      controller: controller.bankNameController,
                      hintText: "Bank Name",
                      labelText: "Bank Name",
                    ),

                    SizedBox(height: 16.h),

                    // Account Number
                    AppTextField(
                      controller: controller.accountNumberController,
                      hintText: "Account Number",
                      labelText: "Account Number",
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter Account Number" : null,
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 16.h),

                    CustomDropDownField(
                      labelText: "Account Type",
                      hintText: "Select Account Type",
                      controller: controller.accountTypeController,
                      items: const [
                        DropDownValueModel(name: 'Saving', value: 'Saving'),
                        DropDownValueModel(name: 'Current', value: 'Current'),
                      ],
                      selectedValue: controller.accountType,
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: UColors.primary,
          ),
          onPressed: controller.isLoading.value
              ? null
              : () => controller.updateBankInfo(),
          child: controller.isLoading.value
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              :  Text("UPDATE", style: TextStyle(fontSize: 16,color: UColors.white)),
        )),
      ),
    );
  }
}
