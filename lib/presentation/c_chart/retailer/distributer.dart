import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/c_chart/retailer/retailer_controller.dart';


class AddDistributorRetailerScreen extends StatelessWidget {
  const AddDistributorRetailerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RetailerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NEW DISTRIBUTOR/RETAILER"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedType.value = 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: controller.selectedType.value == 0
                            ? Colors.black
                            : Colors.grey[200],
                      ),
                      child: Center(
                        child: Text(
                          "DISTRIBUTOR",
                          style: TextStyle(
                            color: controller.selectedType.value == 0
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedType.value = 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: controller.selectedType.value == 1
                            ? Colors.black
                            : Colors.grey[200],
                      ),
                      child: Center(
                        child: Text(
                          "RETAILER",
                          style: TextStyle(
                            color: controller.selectedType.value == 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 16),

            // ✅ Upload Photo Box
            Obx(() => GestureDetector(
              onTap: controller.pickImage,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: controller.selectedImage.value == null
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                      SizedBox(height: 8),
                      Text("Take Photo",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
                    : Image.file(controller.selectedImage.value!,
                    fit: BoxFit.cover),
              ),
            )),
            const SizedBox(height: 16),

            // ✅ Form Fields
            buildTextField("Distributor Business Name", controller.businessNameController),
            buildTextField("Business Type", controller.businessTypeController),
            buildDropdown("Select Brand", controller.brand),
            buildTextField("Address", controller.addressController),
            Row(
              children: [
                Expanded(child: buildDropdown("State", controller.state)),
                const SizedBox(width: 8),
                Expanded(child: buildDropdown("City", controller.city)),
              ],
            ),
            Row(
              children: [
                Expanded(child: buildDropdown("Region", controller.region)),
                const SizedBox(width: 8),
                Expanded(child: buildDropdown("Area", controller.area)),
              ],
            ),
            buildDropdown("Bank Name", controller.bankName),
            buildTextField("Gst No.", controller.gstController),
            buildTextField("Pin code", controller.pinCodeController),
            buildTextField("Person Name", controller.personNameController),
            buildTextField("Mobile", controller.mobileController),

            const SizedBox(height: 20),

            // ✅ Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(() => DropdownButtonFormField<String>(
        value: value.value.isEmpty ? null : value.value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: ["Option 1", "Option 2"].map((e) {
          return DropdownMenuItem(value: e, child: Text(e));
        }).toList(),
        onChanged: (val) => value.value = val ?? "",
      )),
    );
  }
}
