import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

class InfoSectionCard extends StatelessWidget {
  final String title;
  final Map<String, String?> infoData;

  const InfoSectionCard({
    super.key,
    required this.title,
    required this.infoData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: UColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: UColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          ...infoData.entries.map(
                (e) => _infoRow(e.key, e.value),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: UColors.black.withOpacity(0.8),
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              (value != null && value.isNotEmpty) ? value : "-",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
