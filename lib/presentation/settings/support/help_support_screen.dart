import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/settings/support/help_support_controller.dart';

import '../../../core/helpers.dart';

class HelpSupportScreen extends StatelessWidget {
  final HelpSupportController controller = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: Colors.blue,
      ),
      // body: Obx(() {
      //   if (controller.isLoading.value) {
      //     return const Center(child: CircularProgressIndicator());
      //   } else if (controller.hasError.value) {
      //     return Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(
      //             controller.errorMessage.value,
      //             style: const TextStyle(color: Colors.red, fontSize: 16),
      //           ),
      //           const SizedBox(height: 10),
      //           ElevatedButton(
      //             onPressed: controller.retry,
      //             child: const Text("Retry"),
      //           ),
      //         ],
      //       ),
      //     );
      //   }
      //   // } else if (controller.selfListGet.isEmpty) {
      //   //   return const Center(
      //   //     child: Text("No support contacts found"),
      //   //   );
      //   // } else {
      //   //   return RefreshIndicator(
      //   //     onRefresh: controller.fetchUsers,
      //   //     child: ListView.builder(
      //   //       itemCount: controller.selfListGet.length,
      //   //       itemBuilder: (context, index) {
      //   //         final support = controller.selfListGet[index];
      //   //         return Card(
      //   //           margin: const EdgeInsets.symmetric(
      //   //               horizontal: 12, vertical: 6),
      //   //           child: ListTile(
      //   //             leading: const Icon(Icons.support_agent, color: Colors.blue),
      //   //             title: Text(support.supportEmailAddress ?? "No email"),
      //   //             subtitle:
      //   //             Text(support.supportContactNumber ?? "No number"),
      //   //             trailing: IconButton(
      //   //               icon: const Icon(Icons.call, color: Colors.green),
      //   //               onPressed: () {
      //   //                 AppHelpers.showSnackBar(
      //   //                   title: "Call",
      //   //                   message:
      //   //                   "Calling ${support.supportContactNumber ?? ""}",
      //   //                 );
      //   //               },
      //   //             ),
      //   //           ),
      //   //         );
      //   //       },
      //   //     ),
      //   //   );
      //   // }
      // }),
    );
  }
}
