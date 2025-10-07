import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'privacy_policy_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Html(
            data:
                controller.privacyData.value.data ??
                "<p>No privacy policy available.</p>",
            style: {
              "h1": Style(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              "h2": Style(color: Colors.black,),
            },
          ),
        );
      }),
    );
  }
}
