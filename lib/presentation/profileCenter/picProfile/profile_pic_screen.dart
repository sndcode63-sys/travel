import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import '../../home/home_controller.dart';
import 'profile_pic_controller.dart';

class ProfilePicScreen extends StatelessWidget {
  const ProfilePicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final ProfilePicController profileController = Get.put(ProfilePicController());
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
                          'Upload Profile Pic',
                          style: TextStyle(fontSize: 14.sp),
                        ),
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
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RichText(
              text:  TextSpan(
                children: [
                  TextSpan(
                    text: 'Profile Pic ',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Support Only Image. Max Max Image Size 2 MB.',
                    style: TextStyle(
                      fontSize: 16.h,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 50.h),
            Obx(() {
              final user = controller.userData.value;

              Widget avatar;

              if (profileController.profileImage.value != null) {
                avatar = CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(profileController.profileImage.value!),
                );
              } else if (user.profilePic != null && user.profilePic!.isNotEmpty) {
                if (user.profilePic!.startsWith("data:image")) {
                  avatar = CircleAvatar(
                    radius: 80,
                    backgroundImage: MemoryImage(
                      base64Decode(user.profilePic!.split(",").last),
                    ),
                  );
                } else {
                  avatar = CircleAvatar(
                    radius: 80,
                    backgroundImage: CachedNetworkImageProvider(
                      "${user.fullImageUrl}${user.profilePic!}",
                    ),
                    backgroundColor: Colors.grey[200],
                  );
                }
              } else {
                avatar = const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                );
              }

              return Stack(
                children: [
                  avatar,
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: UColors.primary,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () => profileController.pickImage(),
                      ),
                    ),
                  ),
                  if (profileController.profileImage.value != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => profileController.removeImage(),
                      ),
                    ),
                ],
              );
            }),
            Spacer(),
            Obx(() => CustomButton(
              text: controller.isLoading.value ? "UPDATING..." : "UPDATE",
              backgroundColor: UColors.primary,
              onPressed: controller.isLoading.value ? null : () {
                profileController.updateProfile();
              },
            )),
            SizedBox(height: 40.h),

          ],
        ),
      ),
    );
  }
}