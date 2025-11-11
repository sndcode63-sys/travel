import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'associate_profile_info_controller.dart';


class AssociateProfileInfoScreen extends StatelessWidget {
  AssociateProfileInfoScreen({super.key});
  final AssociateProfileInfoController controller = Get.put(AssociateProfileInfoController());

  @override
  Widget build(BuildContext context) {
    final associateId = Get.arguments['associate_id'];

    print("-----------------");
    print("-----------------");
    print("-----------------");
    print(associateId);
    print("-----------------");
    print("-----------------");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {Get.back();

          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
              "Address Info",
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
          ],
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // PIN Code
                TextFormField(
                  controller: controller.pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Pin Code",
                    hintText: "Enter PIN",
                    border: UnderlineInputBorder(),
                  ),
                  maxLength: 6,
                  onChanged: (value) {
                    if (value.length == 6) {
                      controller.fetchAddressFromPin(value);
                    }
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter PIN" : null,
                ),
                const SizedBox(height: 16),

                // Address
                TextFormField(
                  controller: controller.addressController,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Enter Address",
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter Address" : null,
                ),
                const SizedBox(height: 16),

                // City Dropdown
                Obx(() => DropDownTextField(
                  controller: controller.cityController,
                  dropDownList: controller.cityOptions.value,
                  textFieldDecoration: const InputDecoration(
                    labelText: "City",
                    border: UnderlineInputBorder(),
                  ),
                  validator: (val) => controller.validateDropdown(controller.selectedCity.value, "City"),
                  onChanged: (val) {
                    controller.selectedCity.value = val.value;
                  },
                )),
                const SizedBox(height: 16),

                // State Dropdown
                Obx(() => DropDownTextField(
                  controller: controller.stateController,
                  dropDownList: controller.stateOptions.value,
                  textFieldDecoration: const InputDecoration(
                    labelText: "State",
                    border: UnderlineInputBorder(),
                  ),
                  validator: (val) => controller.validateDropdown(
                      controller.selectedState.value, "State"),
                  onChanged: (val) {
                    controller.selectedState.value = val.value;
                  },
                )),
                const SizedBox(height: 16),

                Obx(() => DropDownTextField(
                  controller: controller.countryController,
                  dropDownList: controller.countryOptions.value,
                  textFieldDecoration: const InputDecoration(
                    labelText: "Country",
                    border: UnderlineInputBorder(),
                  ),
                  validator: (val) => controller.validateDropdown(
                      controller.selectedCountry.value, "Country"),
                  onChanged: (val) {
                    controller.selectedCountry.value = val.value;
                  },
                )),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: UColors.primary),
          onPressed: controller.isLoading.value ? null : () {
            if (controller.formKey.currentState!.validate()) {
              controller.updateProfile();
            }
          },
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            "UPDATE",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )),
      ),
    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> items;
  final RxString selectedValue;

  const CustomDropDownField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.items,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 6),
        DropDownTextField(
          controller: controller,
          clearOption: true,
          enableSearch: true,
          dropDownList: items,
          dropDownItemCount: items.length,
          textFieldDecoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
          ),
          onChanged: (val) {
            selectedValue.value = val.value.toString();
          },
        ),

      ],
    );
  }
}
