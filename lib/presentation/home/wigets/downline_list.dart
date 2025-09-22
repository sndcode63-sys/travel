import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_screen.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_grid_view_builder.dart';
import 'custom_item.dart';

class DownlineList extends StatelessWidget {
  const DownlineList({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.person,
      Icons.home,
      Icons.star,
      Icons.settings,
      Icons.phone,
      Icons.message,
      Icons.map,
      Icons.camera_alt,
    ];
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];
    final texts = [
      "Team",
      "SelfDownline",
      "All Downline",
      "Settings",
      "Phone",
      "Messages",
      "Map",
      "Camera",
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: UColors.white,
        border: Border.all(color: UColors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 150.h,
        child: CustomGridView(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 32,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index, item) {
            return InkWell(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.toNamed(AppRoutes.teamScreen);
                    break;
                  case 1:
                    Get.toNamed(AppRoutes.selfDownline);
                    break;
                  case 2:
                    Get.to(() => AllDownlineScreen());

                    break;
                  case 3:
                    break;
                  case 4:
                    break;
                  case 5:
                    break;
                  case 6:
                    break;
                  case 7:
                    break;
                }
              },
              child: CustomIconItem(
                size: 38.sp,
                icon: icons[index],
                text: texts[index],
                backgroundColor: colors[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

