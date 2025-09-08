import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final double borderRadius;
  final Color backgroundColor;
  final Color hintColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final bool showClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hintText = "Search",
    this.onChanged,
    this.onClear,
    this.borderRadius = 12,
    this.backgroundColor = const Color(0xFFF0F0F0),
    this.hintColor = Colors.grey,
    this.textColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showClear = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: hintColor),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (showClear && controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear ?? () => controller.clear(),
              child: Icon(Icons.close, color: hintColor),
            ),
        ],
      ),
    );
  }
}
