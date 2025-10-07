import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import 'relation_information_controller.dart';

class RelationInformationScreen extends StatelessWidget {
  const RelationInformationScreen({super.key});

  Widget buildDropdown({
    required String label,
    required SingleValueDropDownController dropController,
    required Rx<DropDownValueModel?> selectedValue,
    required List<DropDownValueModel> items,
    ValueChanged<dynamic>? onChanged, // Added parameter
  }) {
    final safeItems = items.isNotEmpty
        ? items
        : [DropDownValueModel(name: "No data", value: "0")];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 6),
        DropDownTextField(
          controller: dropController,
          clearOption: true,
          enableSearch: true,
          dropDownList: safeItems,
          dropDownItemCount: safeItems.length,
          textFieldDecoration: InputDecoration(
            hintText: "Select $label",
            border: const UnderlineInputBorder(),
            enabledBorder:
            const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder:
            const UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
          ),
          onChanged: onChanged ?? (val) {
            selectedValue.value = val;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RelationInformationController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Profile"),
              Text("Relation Information", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoadingMaster.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final reraList = controller.masterData.value?.reraSerial
              ?.map((e) => DropDownValueModel(
            name: e.name ?? "",
            value: e.id.toString(),
          ))
              .toList() ??
              [];
          final teamList = controller.masterData.value?.teams
              ?.map((e) => DropDownValueModel(
            name: e.name ?? "",
            value: e.id.toString(),
          ))
              .toList() ??
              [];
          final pinList = controller.masterData.value?.pin
              ?.map((e) => DropDownValueModel(
            name: e.name ?? "",
            value: e.id.toString(),
          ))
              .toList() ??
              [];
          final locationList = controller.masterData.value?.location
              ?.map((e) => DropDownValueModel(
            name: e.name ?? "",
            value: e.id.toString(),
          ))
              .toList() ??
              [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildDropdown(
                  label: "Rera Serial",
                  dropController: controller.selectedR,
                  selectedValue: controller.selectedRera,
                  items: reraList,
                  onChanged: (val) {
                    controller.onReraSerialChanged(val);
                  },
                ),
                const SizedBox(height: 16),


                Obx(() {
                  final isApplied = controller.selectedRera.value?.name == "Applied";

                  return TextField(
                    controller: controller.reraNumberController,
                    decoration: InputDecoration(
                      labelText: isApplied ? "Application Number" : "Rera Number",
                      hintText: isApplied ? "Enter your Application Number" : "",
                      border: const UnderlineInputBorder(),
                      enabledBorder:
                      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder:
                      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                    ),
                    readOnly: false,
                  );
                }),

                const SizedBox(height: 16),
                buildDropdown(
                  label: "Team",
                  dropController: controller.selectedTeam,
                  selectedValue: controller.selectedTeamValue,
                  items: teamList,
                ),
                const SizedBox(height: 16),
                buildDropdown(
                  label: "Pin",
                  dropController: controller.selectedPin,
                  selectedValue: controller.selectedPinValue,
                  items: pinList,
                ),
                const SizedBox(height: 16),
                buildDropdown(
                  label: "Location",
                  dropController: controller.selectedLocation,
                  selectedValue: controller.selectedLocationValue,
                  items: locationList,
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 100),
                CustomButton(
                  text: controller.isUpdating.value ? "Updating..." : "UPDATE",
                  backgroundColor: Colors.blue,
                  onPressed: controller.isUpdating.value
                      ? null
                      : () => controller.updateRelationInfo(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}