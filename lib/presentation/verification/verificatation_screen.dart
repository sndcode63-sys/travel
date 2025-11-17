import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import '../profileCenter/profile_center_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileCenterController>();

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
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Text(
                      "Verification Centre",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xfff2f3f7),
      body: Obx(() {
        final user = profileController.userData.value;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SizedBox(height: 16),

                // Email Verification
                _tile(
                  icon: Icons.email_outlined,
                  title: "Email",
                  value: user.email ?? "Not set",
                  verified: user.emailVerifyStatus == 1,
                  isPending: user.emailVerifyStatus == 2,
                  onTap: user.emailVerifyStatus == 1
                      ? null
                      : () => Get.toNamed(AppRoutes.emailVerification),
                ),
                SizedBox(height: 16),

                // Phone Verification
                _tile(
                  icon: Icons.phone_android,
                  title: "Phone Number",
                  value: user.mobileNumber ?? "Not set",
                  verified: user.phoneVerifyStatus == 1,
                  isPending: user.phoneVerifyStatus == 2,
                  bottomText: user.phoneVerifyStatus == 1
                      ? null
                      : "Contact Admin to change",
                  onTap: user.phoneVerifyStatus == 1
                      ? null
                      : () => Get.toNamed(AppRoutes.phoneVerification),
                ),
                SizedBox(height: 16),

                // Aadhar Verification
                _tile(
                  icon: Icons.credit_card,
                  title: "Aadhar Number",
                  value: user.aadharNumber ?? "Not set",
                  verified: user.aadharVerifyStatus == 1,
                  isPending: user.aadharVerifyStatus == 2,
                  onTap: user.aadharVerifyStatus == 1
                      ? null
                      : () => Get.toNamed(AppRoutes.aadharVerification),
                ),
                SizedBox(height: 16),

                // PAN Verification
                _tile(
                  icon: Icons.credit_card_outlined,
                  title: "PAN Number",
                  value: user.panNumber ?? "Not set",
                  verified: user.panVerifyStatus == 1,
                  isPending: user.panVerifyStatus == 2,
                  onTap: user.panVerifyStatus == 1
                      ? null
                      : () => Get.toNamed(AppRoutes.panVerification),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget _tile({
  required IconData icon,
  required String title,
  required String value,
  required bool verified,
  bool isPending = false,
  String? bottomText,
  VoidCallback? onTap,
}) {
  // ✅ Determine status color and text
  Color statusColor;
  String statusText;

  if (verified) {
    statusColor = Colors.green;
    statusText = "Verified";
  } else if (isPending) {
    statusColor = Colors.orange;
    statusText = "Pending";
  } else {
    statusColor = Colors.red;
    statusText = "Unverified";
  }

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: verified ? null : onTap, // ✅ Disable tap if verified
    child: Opacity(
      opacity: verified ? 0.7 : 1.0, // ✅ Dim if verified
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: verified
              ? Color(0xffe8f5e9) // Light green background if verified
              : Color(0xffeef1f4),
          borderRadius: BorderRadius.circular(16),
          border: verified
              ? Border.all(color: Colors.green.withOpacity(0.3), width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 26, color: verified ? Colors.green : null),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: verified ? Colors.green.shade800 : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            verified
                                ? Icons.check_circle
                                : isPending
                                ? Icons.schedule
                                : Icons.warning,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (verified)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.lock,
                          color: Colors.green,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: verified ? Colors.green.shade700 : null,
              ),
            ),
            if (bottomText != null) ...[
              SizedBox(height: 5),
              Text(
                bottomText,
                style: TextStyle(
                  color: isPending ? Colors.orange : Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
            if (verified) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.green, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "This document is verified and cannot be changed",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ),
  );
}