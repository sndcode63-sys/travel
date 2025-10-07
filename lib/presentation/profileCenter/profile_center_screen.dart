import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import 'profile_center_controller.dart';


class ProfileCenterScreen extends StatelessWidget {
  const ProfileCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCenterController controller = Get.put(ProfileCenterController());

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
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),

      ),
      body: Container(
        color: Colors.blue.withOpacity(0.08),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildProfileCard(
              icon: Icons.person,
              iconColor: Colors.pink,
              title: 'General Information',
              subtitle: 'Set personal info like name, email, mobile, gender, etc.',
              onTap: () {
                Get.toNamed(AppRoutes.generalInformation);
              },
            ),
            _buildProfileCard(
              icon: Icons.image,
              iconColor: Colors.blue,
              title: 'Profile Picture',
              subtitle: 'Upload/Change Profile Pic.',
              onTap: () {
                Get.toNamed(AppRoutes.profilePic);

              },
            ),
            _buildProfileCard(
              icon: Icons.location_on,
              iconColor: Colors.red,
              title: 'Address Information',
              subtitle: 'Add address (pin code, city, state, country, etc.).',
              onTap: () {
                Get.toNamed(AppRoutes.profileInfo);

              },
            ),

            _buildProfileCard(
              icon: Icons.link,
              iconColor: Colors.teal,
              title: 'Relation Information',
              subtitle: 'Add team, RERA details, pin name, trainee info, etc.',
              onTap: () {
                Get.toNamed(AppRoutes.relationInfo);

              },
            ),
            _buildProfileCard(
              icon: Icons.verified_user,
              iconColor: Colors.blue.shade800,
              title: 'Verification Documents',
              subtitle: 'Upload verification documents (Aadhar, PAN, driving license, voter ID, etc.).',
              onTap: () {
                Get.toNamed(AppRoutes.verificationDocuments);

              },
            ),
            _buildProfileCard(
              icon: Icons.account_balance,
              iconColor: Colors.orange.shade800,
              title: 'Bank Information',
              subtitle: 'Add bank details (IFSC code, account number, etc.).',
              onTap: () {
                Get.toNamed(AppRoutes.bankInfo);

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13.0,
                      ),
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

