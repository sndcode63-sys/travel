import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profileCenter/profile_center_controller.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);

  final ProfileCenterController profileController = Get.find<ProfileCenterController>();

  // ✅ Generic Verification Card Widget
  Widget _buildVerificationTile({
    required String title,
    required String type,
    required int status,
    required VoidCallback onTap,
  }) {
    final isVerified = status == 1;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(
          isVerified ? Icons.verified : Icons.error_outline,
          color: isVerified ? Colors.green : Colors.orangeAccent,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          isVerified ? "Verified" : "Pending Verification",
          style: TextStyle(
            color: isVerified ? Colors.green : Colors.redAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: !isVerified
            ? ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Verify",
            style: TextStyle(color: Colors.white),
          ),
        )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Center"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        final user = profileController.userData.value;

        return profileController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVerificationTile(
                title: "Email Verification",
                type: "Email",
                status: user.emailVerifyStatus ?? 0,
                onTap: () => _onVerifyTap("Email"),
              ),
              _buildVerificationTile(
                title: "Phone Verification",
                type: "Phone",
                status: user.phoneVerifyStatus ?? 0,
                onTap: () => _onVerifyTap("Phone"),
              ),
              _buildVerificationTile(
                title: "Aadhar Verification",
                type: "Aadhar",
                status: user.aadharVerifyStatus ?? 0,
                onTap: () => _onVerifyTap("Aadhar"),
              ),
              _buildVerificationTile(
                title: "PAN Verification",
                type: "PAN",
                status: user.panVerifyStatus ?? 0,
                onTap: () => _onVerifyTap("PAN"),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text("Refresh Status", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () async {
                    await profileController.fetchDataUser();
                    Get.snackbar(
                      "Refreshed",
                      "Latest verification statuses fetched successfully.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.2),
                      colorText: Colors.black,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _onVerifyTap(String type) async {
    final result = await Get.toNamed(
      '/otpVerification',
      arguments: {"type": type},
    );

    if (result != null && result['verified'] == true) {
      profileController.markAsVerified(type);

      Get.snackbar(
        "Success",
        "$type verification completed!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.black,
      );
    }
  }
}
