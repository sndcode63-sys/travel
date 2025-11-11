import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import '../../allAssociate/all_associate_screen.dart';
import 'associate_pending_controller.dart';

class AssociatePendingScreen extends StatelessWidget {
  AssociatePendingScreen({super.key});
  final controller = Get.put(AssociatePendingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hasError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.pendingAssociateList.isEmpty) {
          return const Center(child: Text("No associates found"));
        }
        return CustomListView(
          itemCount: controller.pendingAssociateList.length,
          itemBuilder: (context, index, item) {
            final associateList = controller.pendingAssociateList[index];
            return Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        associateList.fullName ?? "Unknown",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          associateList.active ?? "",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  _buildInfoRow("Email", associateList.email),
                  _buildInfoRow("Mobile", associateList.phone2),
                  _buildInfoRow("RERA No", associateList.reraNumber),
                  _buildInfoRow("Created At", associateList.createdAt),
                  SizedBox(height: 12.h),

                  Divider(color: Colors.grey.shade300, thickness: 1),
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        label: "Edit Details",
                        color: UColors.primary,
                        icon: Icons.edit,
                        onTap: () {
                          Get.toNamed(AppRoutes.addAssociate,
                            arguments: {
                              'associate': associateList,
                              'isEdit': true,
                            },);
                        },
                      ),
                      _buildActionButton(
                        label: "Remove",
                        color: Colors.redAccent,
                        icon: Icons.delete,
                        onTap: () {},
                      ),
                      _buildActionButton(
                        label: "View Details",
                        color: Colors.green,
                        icon: Icons.visibility,
                        onTap: () {
                          Get.to(
                                () => AllAssociateScreen(),
                            arguments: associateList,
                            transition: Transition.fadeIn,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  // Reusable widget for info row
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
          ),
          Flexible(
            child: Text(
              value ?? "-",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable button for actions
  Widget _buildActionButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
