import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_screen.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_controller.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_listview_builder.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

class SelfDownloadScreen extends StatelessWidget {
  const SelfDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SelfController controller = Get.put(SelfController());

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
                        Text("Self Downline", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Get.to(AllDownlineScreen());
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
                itemCount: controller.selfListGEt.length,
                itemBuilder: (context, index, item) {
                  final selfList = controller.selfListGEt[index];
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
                              child: Center(
                                  child: Text(selfList.id.toString())),
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
                              "Rera No.",
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
                              selfList.name ?? "",
                              style: TextStyle(
                                color: UColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              selfList.associateCode ?? "",
                              style: TextStyle(
                                color: UColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              selfList.reraNo ?? "",
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
