import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utlis/app_routes.dart';
import '../../utlis/constents/app_sizes.dart';
import '../../utlis/constents/colors.dart';
import '../../utlis/custom_widgets/custom_listview_builder.dart';
import 'library_controller.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryController controller = Get.find<LibraryController>();

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Library", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
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
        body: SafeArea(
            child: SizedBox.expand(
              child: Container(
                color: Colors.blue.withOpacity(0.08),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 15.h,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: UColors.white,
                          border: Border.all(color: UColors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(
                              color: Colors.black.withAlpha(75),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: UColors.primary),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: TextStyle(fontSize: 14, color: UColors.primary),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Expanded(child: SchemeList(controller: controller)),
                    ],
                  ),
                ),
              ),
            )

        ),
      ),
    );
  }
}

class SchemeList extends StatelessWidget {
  const SchemeList({super.key, required this.controller});

  final LibraryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.livn.isEmpty) {
        return Center(child: Text('No schemes available'));
      }

      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: controller.livn.length,
        itemBuilder: (context, index) {
          final scheme = controller.livn[index];
          return InkWell(
            onTap: () {

              Get.toNamed(
                AppRoutes.libraryHead,
                arguments: {
                  'schemeId': scheme.id,
                  'schemeName': scheme.name,
                },
              );


              print('➡ Selected Scheme -> ID: ${scheme.id}, Name: ${scheme.name}');



              print(
                '➡ Selected Scheme -> ID: ${scheme.id}, '
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: UColors.white,
                border: Border.all(color: UColors.grey, width: 1),
              ),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.9, end: 1.0),
                    duration: Duration(milliseconds: 250),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: UColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent.withAlpha(60),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              controller.getFirstAndLastLetter(
                                scheme.name.toString(),
                              ),
                              style: TextStyle(
                                color: UColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 15.w,),
                  Expanded(
                    child: Text(
                      scheme.name.toString(),
                      style: TextStyle(
                        fontSize: 16.h,
                        color: UColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}