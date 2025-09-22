import 'dart:math';
import 'package:flutter/material.dart';

/// 🔹 Fully reusable Custom GridView builder (Stateless)
class CustomGridView<T> extends StatelessWidget {
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

  /// Grid delegate (default = 2 crossAxisCount)
  final SliverGridDelegate gridDelegate;

  /// Scroll direction (default vertical)
  final Axis scrollDirection;

  const CustomGridView({
    super.key,
    this.items,
    this.itemCount,
    required this.itemBuilder,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
    ),
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

    return GridView.builder(
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      gridDelegate: gridDelegate,
      itemCount: count,
      itemBuilder: (context, index) =>
          itemBuilder(context, index, items != null ? items![index] : null),
    );
  }
}
