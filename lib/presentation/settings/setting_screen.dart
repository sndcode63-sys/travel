import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';

import '../../utlis/app_routes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Setting",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Profile Setting",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(icon: const Icon(Icons.settings), onPressed: () {
                }),
              ],
            ),
          ),
        ),
      ),
body: Column(
  children: [
    SizedBox(height: 20.h,),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCard(
              svgPath:AppImages.profile ,
              text: 'Profile Centre',
              onTap: () {
                Get.toNamed(AppRoutes.profileCenter);
              },
            ),
            _buildCard(
              svgPath:AppImages.lock ,
              text: 'Reset Password',
              onTap: () {

              },
            ),
            _buildCard(
              svgPath:AppImages.privacy ,
              text: 'Privacy Policy',
              onTap: () {

              },
            ),
            _buildCard(
              svgPath:AppImages.helps ,
              text: 'Help & Support',
              onTap: () {

              },
            ),
          ],
        ),
      ),
    ),
  ],
)
      ,
    );
  }



  Widget _buildCard({
    required String svgPath, 
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath,
                color: UColors.primary,
                width: 40.0,
                height: 40.0,
              ),
              const SizedBox(height: 8.0),
              Text(
                text,
                style:  TextStyle(
                  color: UColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




