import 'package:flutter/material.dart';

import '../../../utlis/constents/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    final isDark = theme.brightness == Brightness.dark;

    final iconColor = appBarTheme.iconTheme?.color ?? (isDark ? UColors.white : UColors.black);
    final iconSize = appBarTheme.iconTheme?.size ?? 24.0;
    final actionColor = appBarTheme.actionsIconTheme?.color ?? iconColor;
    final titleStyle = appBarTheme.titleTextStyle ?? TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: iconColor,
    );
    final backgroundColor = appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 5,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.15)
                : Colors.black.withOpacity(0.03),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Back Button + Title
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: iconColor, size: iconSize),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: titleStyle),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: titleStyle.color?.withOpacity(0.6),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            /// Actions
            Row(
              children: actions?.map((w) {
                if (w is IconButton) {
                  return IconButton(
                    icon: w.icon,
                    onPressed: w.onPressed,
                    color: actionColor,
                  );
                }
                return w;
              }).toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
