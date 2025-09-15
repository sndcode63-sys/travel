import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

class AddVisitScreen extends StatelessWidget {
  final AddVisitController controller = Get.put(AddVisitController());

  @override
  Widget build(BuildContext context) {
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
                          "Add Visit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Scheme List"
                          "",
                          style: TextStyle(fontSize: 14),
                        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            15.h,
            AppTextField(hintText: "Search",
            borderColor: Colors.grey.withAlpha(75),
            fillColor: UColors.white,),
            10.h,

            Expanded(child: SchemeList(controller: controller)),
          ],
        ),
      ),
    );
  }
}

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
          return InkWell(
            onTap: (){
              Get.toNamed(AppRoutes.addMember);
            },
            child: Container(
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
            ),
          );
        },
      );
    });
  }
}
