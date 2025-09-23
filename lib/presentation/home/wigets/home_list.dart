import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'custom_item.dart';

class HomeList extends StatelessWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:70.h,
      child: CustomListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index, item) {
          final icons = [
            Icons.person,
            Icons.home,
            Icons.star,
            Icons.settings,
          ];
          final colors = [
            Colors.red,
            Colors.blue,
            Colors.green,

            Colors.orange,
          ];
          final texts = ["Add Visit", "Add Meeting", "Library", "Plot"];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                switch (index) {
                  case 0:
                    Get.toNamed(AppRoutes.addVisit);
                    break;
                  case 1:
                    Get.toNamed(AppRoutes.addMeeting);
                    break;
                  case 2:
                    break;
                  case 3:
                    break;
                }
              },
              child: CustomIconItem(
                icon: icons[index],
                text: texts[index],
                backgroundColor: colors[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
