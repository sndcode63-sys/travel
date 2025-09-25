import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import '../../utlis/constents/colors.dart';
import '../../utlis/custom_widgets/custom_button.dart';

class BankVerification extends StatelessWidget {
  const BankVerification({super.key});

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
                        Text('Bank Info', style: TextStyle(fontSize: 14.sp)),
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
                  AppTextField(
                    hintText: "IFSC Number",
                    labelText: "IFSC Number",
                  ),
                  AppTextField(hintText: "Bank Name", labelText: "Bank Name"),
                  AppTextField(
                    hintText: "Bank Account",
                    labelText: "Bank Account",
                  ),
                  AppTextField(
                    hintText: "Account Holder Name",
                    labelText: "Account Holder Name",
                  ),
                  AppTextField(hintText: "Branch", labelText: "Branch"),
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
    );
  }
}
