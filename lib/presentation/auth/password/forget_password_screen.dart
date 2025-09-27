import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/password/forget_password_controller.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/color_constants.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';
import '../../../utlis/formatters/validato.dart';
import '../../../utlis/theme/widgets_theme/text_theme.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.08),

          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.adaptive.arrow_back,),
          ),
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              color: Colors.blue.withOpacity(0.08),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h,),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.forgetIcon,height:200.h,width: 200.w,),
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(height: 20.h,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: UColors.black,fontWeight: FontWeight.bold,fontSize: 20),

                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Enter your email/mobile to get OTP',
                        style: Theme.of(context).textTheme. titleMedium,

                      ),
                    ),
                    SizedBox(height: 30.h,),
                    /// Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: controller.formKey,
                        child: AppTextField(
                          controller: controller.emailController,
                          hintText: "Email Address / Mobile Number",
                          labelText:"Email Address / Mobile Number",
                          validator: Validators.emailOrMobile,

                        ),
                      ),
                    ),

                    SizedBox(height: 49.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        backgroundColor: AppColors.primary,
                        text: "GET OTP",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        onPressed: () {
                          controller.verifyOtp();
                        },
                      ),
                    ),
                  ],
                )

              ),
            ),
          ),
        ),
      ),
    );
  }
}
