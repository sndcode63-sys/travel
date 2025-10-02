import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/login/login_controller.dart';
import 'package:travell_booking_app/utlis/constents/color_constants.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/formatters/validato.dart';
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            color: Colors.blue.withOpacity(0.08),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child:Form(
                key: controller.formKey,
                child: Column(
                  children: [
                     SizedBox(height: 30.h),

                    Image.asset(AppImages.logo,height: 200.h,width: 200.w,),
                    Text(
                      "Visit App",
                      style: TextStyle(color: UColors.primary,fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 16.h),

                    /// Login Card
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text(
                          "Sign In To Your Account",
                           style: TextStyle(color: UColors.black,fontSize: 24,fontWeight: FontWeight.bold),

                         ),
                         SizedBox(height: 20.h),
                        /// Email Field
                        AppTextField(
                          controller: controller.emailController,
                          hintText: "Email Address / Mobile Number",
                          labelText:'Email Address / Mobile Numbe' ,
                          validator: Validators.emailOrMobile,

                        ),
                         SizedBox(height: 20.h),

                        Obx(() => AppTextField(
                          controller: controller.passwordController,
                          hintText: "Password",
                          labelText:'Password' ,

                          obscureText: controller.obscurePassword.value,
                          // validator: Validators.password,

                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: controller.togglePassword,
                          ),
                        )),


                         SizedBox(height: 12.h),

                        /// Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.forgetPassword);
                            },
                            child:  Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: UColors.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(height: 30.h),

                        // Sign In Button
                        CustomButton(
                          text: "SIGN IN",
                          fontSize: 16.sp,
                          backgroundColor: AppColors.primary,
                          onPressed: controller.onSignIn,
                        )
                      ],

                    ),

                     SizedBox(height: 60.h),

                    /// Footer
                    Column(
                      children:  [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: "Design & Developed By "),
                              TextSpan(
                                text: "DemoTesting",
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: UColors.primary,
                                ),
                              ),
                              const TextSpan(text: "\nSoftware Company"),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Version: 1.0.0",
                          style: TextStyle(color: UColors.black,fontSize: 14,fontWeight: FontWeight.w400),

                        ),
                      ],
                    ),
                  ],
                ),
              )

            ),
          ),
        ),
      ),
    );
  }
}
