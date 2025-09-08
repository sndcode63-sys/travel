import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/my_personal_custom/my_custom.dart';



class MyDemoScreen extends StatelessWidget {
  const MyDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustom.buildAppBar(),
      body:MyCustom.customTabBar(),
    );
  }
  
}


class CustomCheckList extends StatelessWidget {
  CustomCheckList({Key? key}) : super(key: key);

  final List<String> reasons = [
    "Reason 1 to choose us",
    "Reason 2 to choose us",
    "Reason 3 to choose us",
    "Reason 4 to choose us",
    "Reason 5 to choose us",
  ];

  // ValueNotifier for checkboxes
  final ValueNotifier<List<bool>> selected = ValueNotifier(List.generate(5, (_) => false));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ValueListenableBuilder<List<bool>>(
        valueListenable: selected,
        builder: (context, value, _) {
          return Column(
            children: List.generate(reasons.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: _checkRow(index, reasons[index], value[index]),
              );
            }),
          );
        },
      ),
    );
  }

  // Widget function for single row
  Widget _checkRow(int index, String text, bool isSelected) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selected.value = List.from(selected.value)..[index] = !isSelected;
          },
          child: Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}




class PageViewWithWidgetFunction extends StatelessWidget {
  const PageViewWithWidgetFunction({Key? key}) : super(key: key);

  // 🔥 Ye hai widget function
  Widget pageWidget(Color color, String text) {
    return               Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade50,
      child: Image.asset(AppImages.banner1,height: 200,),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 4, // total pages
        itemBuilder: (context, index) {
          return pageWidget(
            Colors.primaries[index % Colors.primaries.length], // dynamic color
            "Page ${index + 1}", // dynamic text
          );
        },
      ),
    );
  }
}
