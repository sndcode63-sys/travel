import 'package:flutter/material.dart';

///CUSTOM BUTTON
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  /// Appearance
  final double? height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final BorderSide? border;
  final Gradient? gradient;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? iconColor;
  final double iconSize;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.height,
    this.width,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.border,
    this.gradient,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.iconSize = 20,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? screenSize.height * 0.065,
        width: width ?? double.infinity,
        child: Material(
          color: isOutlined
              ? Colors.transparent
              : (gradient == null ? backgroundColor : Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ??
                BorderSide(
                  color: isOutlined ? backgroundColor : Colors.transparent,
                  width: 1.5,
                ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isLoading ? null : onPressed,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: gradient,
              ),
              child: Padding(
                padding: padding,
                child: Center(
                  child: isLoading
                      ? SizedBox(
                    height: fontSize,
                    width: fontSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(textColor),
                    ),
                  )
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null) ...[
                        Icon(prefixIcon,
                            size: iconSize, color: iconColor ?? textColor),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                          ),
                        ),
                      ),
                      if (suffixIcon != null) ...[
                        const SizedBox(width: 8),
                        Icon(suffixIcon,
                            size: iconSize, color: iconColor ?? textColor),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
