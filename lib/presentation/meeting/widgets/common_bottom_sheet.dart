import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utlis/constents/colors.dart';

Widget buildBottomSheet({
  required String title,
  required String imageUrl,
  required String date,
  required String time,
  required String status,
  required Color statusColor,
  required String description,
  required int numberOfUsers,
  String dateLabel = "Meeting Date",
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 40.w,
            height: 5.h,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        Text(
          'Number of User: $numberOfUsers',
          style: TextStyle(
            color: UColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 15.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 320.h,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(height: 20.h),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateLabel,  // <-- use the dynamic label
                    style: TextStyle(
                        color: UColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp)),
                Text("$date $time",
                    style: TextStyle(
                        color: UColors.darkerGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1, color: UColors.grey),

            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status",
                    style: TextStyle(
                        color: UColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1, color: UColors.grey),

            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Description",
                    style: TextStyle(
                        color: UColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp)),
                Expanded(
                  child: Text(description,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: UColors.darkerGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp)),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1, color: UColors.grey),
          ],
        ),
      ],
    ),
  );
}
