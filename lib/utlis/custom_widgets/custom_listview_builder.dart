import 'dart:math';
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// 🔹 Fully reusable Custom ListView builder (Stateless)
class CustomListView<T> extends StatelessWidget {
  /// Optional data list
  final List<T>? items;

  /// Optional fixed item count
  final int? itemCount;

  /// Item builder callback
  final Widget Function(BuildContext context, int index, T? item) itemBuilder;

  /// Physics (default = BouncingScrollPhysics)
  final ScrollPhysics physics;

  /// Optional padding
  final EdgeInsetsGeometry? padding;

  /// Optional separator between items
  final Widget? separator;

  /// Scroll direction (default vertical)
  final Axis scrollDirection;

  const CustomListView({
    super.key,
    this.items,
    this.itemCount,
    required this.itemBuilder,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.separator,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    int count = 0;

    if (items != null && itemCount != null) {
      count = min(items!.length, itemCount!);
    } else if (items != null) {
      count = items!.length;
    } else if (itemCount != null) {
      count = itemCount!;
    }

    if (separator != null) {
      return ListView.separated(
        physics: physics,
        padding: padding,
        scrollDirection: scrollDirection,
        itemCount: count,
        itemBuilder: (context, index) =>
            itemBuilder(context, index, items != null ? items![index] : null),
        separatorBuilder: (context, index) => separator!,
      );
    } else {
      return ListView.builder(
        physics: physics,
        padding: padding,
        scrollDirection: scrollDirection,
        itemCount: count,
        itemBuilder: (context, index) =>
            itemBuilder(context, index, items != null ? items![index] : null),
      );
    }
  }
}


