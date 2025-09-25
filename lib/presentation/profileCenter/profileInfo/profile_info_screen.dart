import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import 'profile_info_controller.dart';



class ProfileInfoScreen extends StatelessWidget {
  ProfileInfoScreen({super.key});

  final ProfileInfoController controller = Get.put(ProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Relation Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
              "Relation Information",
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.blue.withOpacity(0.08),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  CustomDropDownField(
                    labelText: "Rera Serial",
                    hintText: "Select Rera Serial",
                    controller: controller.reraSerialController,
                    items: const [
                      DropDownValueModel(name: 'Option 1', value: "Option 1"),
                      DropDownValueModel(name: 'Option 2', value: "Option 2"),
                      DropDownValueModel(name: 'Option 3', value: "Option 3"),
                    ],
                    selectedValue: controller.selectedReraSerial,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    labelText: "Rera Number",
                    hintText: "Enter Rera Number*",
                    showStar: true,
                  ),
                  const SizedBox(height: 16),
                  CustomDropDownField(
                    labelText: "Team Name",
                    hintText: "Select Team",
                    controller: controller.teamController,
                    items: const [
                      DropDownValueModel(name: 'Team A', value: "Team A"),
                      DropDownValueModel(name: 'Team B', value: "Team B"),
                      DropDownValueModel(name: 'Team C', value: "Team C"),
                    ],
                    selectedValue: controller.selectedTeam,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    labelText: "Pin Name",
                    hintText: "Trainee",
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    labelText: "Location",
                    hintText: "Mansarover",
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomAppBar(child: CustomButton(text: "UPDATE",backgroundColor: UColors.primary,),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    bool showStar = false,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        suffixIcon: showStar
            ? const Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            '*',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        )
            : null,
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
        const SizedBox(height: 8),
        Obx(() => Text(
          'Selected: ${selectedValue.value}',
          style: const TextStyle(color: Colors.grey),
        )),
      ],
    );
  }
}
