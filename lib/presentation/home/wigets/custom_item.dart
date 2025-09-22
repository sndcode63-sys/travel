import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double borderRadius;
  final EdgeInsets padding;

  const CustomIconItem({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.size = 38,
    this.borderRadius = 15,
    this.padding = const EdgeInsets.all(5),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(icon, color: iconColor, size: size),
        ),
         SizedBox(height: 5.sp),
        Text(
          text,
          style:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
