import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'list_distributres_controller.dart'; // for kIsWeb


class DistributorRetailerListScreen extends StatelessWidget {
  const DistributorRetailerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListDistributresController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Distributor / Retailer List"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: item.imagePath != null
                    ? Image.file(File(item.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.store, size: 40),
                title: Text(item.businessName),
                subtitle: Text("${item.personName} - ${item.mobile}"),
                trailing: Text(item.type == 0 ? "Distributor" : "Retailer"),
              ),
            );
          },
        );
      }),
    );
  }
}
