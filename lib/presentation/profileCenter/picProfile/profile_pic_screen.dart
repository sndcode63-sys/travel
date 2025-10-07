import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import '../../../data/services/api_manager.dart';
import 'profile_pic_controller.dart';



class ProfilePicScreen extends StatelessWidget {
  const ProfilePicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePicController profileController = Get.put(ProfilePicController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Profile Pic"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Profile Pic ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Support Only Image. Max Image Size 1 MB.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Obx(() {
              final localImage = profileController.profileImage.value;
              final savedProfile = AuthService.to.profileImageBase64.value;

              Widget avatar;

              if (localImage != null) {
                // Local selected image
                avatar = CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(localImage),
                );
              } else if (savedProfile.isNotEmpty) {
                // Base64 image (instant)
                avatar = CircleAvatar(
                  radius: 80,
                  backgroundImage: MemoryImage(base64Decode(savedProfile.split(",").last)),
                );
              } else {
                // Default placeholder
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
                  if (localImage != null)
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
            const Spacer(),
            Obx(() => CustomButton(
              text: profileController.isLoading.value ? "UPDATING..." : "UPDATE",
              backgroundColor: UColors.primary,
              onPressed: profileController.isLoading.value
                  ? null
                  : () => profileController.updateProfile(),
            )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
