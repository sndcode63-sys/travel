import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import '../self_download/self_download_screen.dart';
import 'all_downline_controller.dart';

class AllDownlineScreen extends StatelessWidget {
  const AllDownlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllDownlineController controller = Get.put(AllDownlineController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
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
                      children: const [
                        Text(
                          "My Team",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("All Downline", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Get.to(SelfDownloadScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          10.h,
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: UColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: UColors.grey)
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: UColors.grey,),
                  20.w,
                  Text('Search Associate Name',
                      style: TextStyle(color: UColors.grey)),
                ],
              )
          ),
          5.h,
          Expanded(
            child: Obx(() {
              return CustomListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.vertical,
                itemCount: controller.allDownline.length,
                itemBuilder: (context, index, item) {
                  final allListD = controller.allDownline[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: UColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: UColors.grey),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: UColors.grey,
                              ),
                              child: Center(child: Text(allListD.id.toString())),
                            ),
                          ],
                        ),
                        10.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                color: UColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Code",
                              style: TextStyle(
                                color: UColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Roll NO.",
                              style: TextStyle(
                                color: UColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        30.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(":"), Text(":"), Text(":")],
                        ),
                        10.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allListD.name ?? "",
                              style: TextStyle(
                                color: UColors.black,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              allListD.associateCode ?? "",
                              style: TextStyle(
                                color: UColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              allListD.reraNo ?? "",
                              style: TextStyle(
                                color: UColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
