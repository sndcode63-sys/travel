import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utlis/constents/colors.dart';

class DashboardItem extends StatelessWidget {
  final String label;
  final String assetPath;
  final double size;
  final VoidCallback? onTap;

  const DashboardItem({
    Key? key,
    required this.label,
    required this.assetPath,
    this.size = 35,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UColors.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SvgPicture.asset(
              assetPath,
              height: size,
              width: size,
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 80,
            child: AutoSizeText(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 10,
              style: TextStyle(
                color: UColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DashboardSection extends StatelessWidget {
  final String title;
  final List<DashboardItem> items;
  final bool wrapInsteadOfRow;

  const DashboardSection({
    Key? key,
    required this.title,
    required this.items,
    this.wrapInsteadOfRow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: TextStyle(
              color: UColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: wrapInsteadOfRow
                ? Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 16,
              children: items,
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items,
            ),
          ),
        ),
      ],
    );
  }
}
