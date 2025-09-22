import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'custom_item.dart';

class ReportList extends StatelessWidget {
  const ReportList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: UColors.white,
          border: Border.all(color: UColors.grey),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: CustomListView(
          physics: NeverScrollableScrollPhysics(),
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
            final texts = ["Visit", "Meeting", "Sales", "Plot Activity"];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.toNamed(AppRoutes.visitList);
                      break;
                    case 1:
                      Get.toNamed(AppRoutes.meeting);

                      break;
                    case 2:
                      break;
                    case 3:
                      break;
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconItem(
                      size: 38.sp,
                      icon: icons[index],
                      text: texts[index],
                      backgroundColor: colors[index],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
