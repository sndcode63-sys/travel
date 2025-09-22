import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_download_screen.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_listview_builder.dart';

import '../../utlis/app_routes.dart';
import 'allDownline/all_downline_screen.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(70.h),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Team",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Report Data", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
      Expanded(
        child: CustomListView(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: 2,
          itemBuilder: (context, index, item) {
            final titles = [
              "Self Downline",
              "All Downline",
            ];
            final subtitles = [
              [
                "Group of associate who have been ",
                "sponsored by a single individual directly",
              ],
              [
                "All associates connected in the",
                "complete downline network",
              ],
            ];

            return InkWell(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.toNamed(AppRoutes.selfDownline);
                    break;
                  case 1:
                    Get.to(() => AllDownlineScreen());
                    break;
                }
              },
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: UColors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: UColors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      titles[index],
                      style: TextStyle(
                        color: UColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),

                    /// Subtitle Lines
                    ...subtitles[index].map(
                          (line) => Text(
                        line,
                        style: TextStyle(
                          color: UColors.primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )

      ],
      ),
    );
  }
}
