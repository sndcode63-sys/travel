import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../utlis/constents/colors.dart';
import '../add_visit_controller.dart';

class SchemeList extends StatelessWidget {
  const SchemeList({
    super.key,
    required this.controller,
  });

  final AddVisitController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.schemes.isEmpty) {
        return Center(child: Text('No schemes available'));
      }
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: controller.schemes.length,
        itemBuilder: (context, index) {
          final scheme = controller.schemes[index];
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],

              border: Border.all(color: UColors.grey),
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: UColors.grey,
                  ),
                  child: Center(child: Text("${scheme.schemeId}")),
                ),
                15.w,
                Text(
                  scheme.schemeName ?? '',
                  style: TextStyle(fontSize: 16, color: UColors.primary,fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
