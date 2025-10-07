import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';
import 'enter_summary_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'enter_summary_controller.dart';
import '../../../../utlis/constents/colors.dart';
import '../../../../utlis/custom_widgets/custom_button.dart';
import '../../../../utlis/custom_widgets/custom_text_field.dart';

class EnterSummaryScreen extends StatelessWidget {
  EnterSummaryScreen({super.key});
  final EnterSummaryController controller = Get.put(EnterSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Dispute Summary"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            CustomDropDownField(
              labelText: "Dispute Reason",
              hintText: "Select Dispute Reason",
              controller: controller.disputeReasonController,
              items: const [
                DropDownValueModel(name: 'Plot', value: 'Plot'),
                DropDownValueModel(name: 'Other', value: 'Other'),
              ],
              selectedValue: controller.disputeReason,
              onChanged: controller.onDisputeReasonSelected,
            ),

            // If "Plot" selected → show API-based dropdowns
            Obx(() {
              if (controller.disputeReason.value?.value != 'Plot') {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  SizedBox(height: 16.h),
                  Obx(() {
                    if (controller.isProjectLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    return CustomDropDownField(
                      labelText: "Project Name",
                      hintText: "Select Project Name",
                      controller: controller.projectNameController,
                      items: controller.projectList,
                      selectedValue: controller.projectName,
                      onChanged: controller.onProjectNameSelected,
                    );
                  }),
                  SizedBox(height: 16.h),
                  CustomDropDownField(
                    labelText: "Plot Name",
                    hintText: "Select Plot Name",
                    controller: controller.plotNameController,
                    items: const [
                      DropDownValueModel(name: 'Plot 1', value: 'P1'),
                      DropDownValueModel(name: 'Plot 2', value: 'P2'),
                    ],
                    selectedValue: controller.plotName,
                    onChanged: controller.onPlotNameSelected,
                  ),
                ],
              );
            }),

            SizedBox(height: 16.h),
            AppTextField(
              hintText: "Subject",
              labelText: "Subject",
              showStar: true,
            ),
            SizedBox(height: 16.h),
            AppTextField(
              hintText: "Description",
              labelText: "Description",
              showStar: true,
            ),
          ],
        ),
      ),

    );
  }
}

class CustomDropDownField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> items;
  final Rx<DropDownValueModel?> selectedValue;
  final ValueChanged<DropDownValueModel?>? onChanged;

  const CustomDropDownField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.items,
    required this.selectedValue,
    this.onChanged,
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
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
          ),
          onChanged: (val) {
            selectedValue.value = val;
            if (onChanged != null) onChanged!(val);
          },
        ),
      ],
    );
  }
}
