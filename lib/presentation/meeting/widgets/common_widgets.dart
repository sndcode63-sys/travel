import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

class VisitCard extends StatelessWidget {
  final String imageUrl;
  final int numberOfUsers;
  final String description;
  final String date;
  final String time;
  final String status;
  final Color statusColor;

  const VisitCard({
    super.key,
    required this.imageUrl,
    required this.numberOfUsers,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Avatar / Image
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              
              color: UColors.grey,
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              memCacheWidth: 200,
              memCacheHeight: 200,
            ),
          ),

          SizedBox(width: 15.w),

          /// Name + Description + Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // vertically center
              children: [
                Text(
                  'Number of User: $numberOfUsers',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Description: $description",
                  style: TextStyle(fontSize: 13.sp, color: Colors.blue),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Meeting Date: $date $time",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),

          /// Status Badge
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              height: 24.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: statusColor.withAlpha(40),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
