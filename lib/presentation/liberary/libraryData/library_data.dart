import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'library_data_controller.dart';

class LibraryDataScreen extends StatelessWidget {
  final LibraryDataController controller = Get.put(LibraryDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
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
                      children: [
                        Text(
                          "Library",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Scheme List", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue.withOpacity(0.08),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${controller.errorMessage.value}'));
          }

          if (controller.livn.isEmpty) {
            return Center(child: Text('No Data Found'));
          }

          return CustomListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: controller.livn.length,
            itemBuilder: (context, index, item) {
              final headL = controller.livn[index];
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Project Name: ${headL.schemeName}"),
                            Text("Library Head Name: ${headL.libraryHeadName}"),
                          ],
                        ),
                      ),
                    ),
                    Text("Library Data",style: TextStyle(color: UColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                    SizedBox(height: 20.h,),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
