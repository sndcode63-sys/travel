
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;       // Design font size
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final EdgeInsetsGeometry? padding;

  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget txt = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,   // responsive font
        fontWeight: fontWeight,
      ),
    );

    if (padding != null) {
      return Padding(
        padding: padding!,
        child: txt,
      );
    } else {
      return txt;
    }
  }
}
