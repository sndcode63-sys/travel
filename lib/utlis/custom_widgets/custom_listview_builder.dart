import 'dart:math';
import 'package:flutter/material.dart';

/// 🔹 Fully reusable Custom ListView builder
class CustomListView<T> extends StatefulWidget {
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

  /// Pagination callback
  final VoidCallback? onEndReached;

  /// Whether more data is available
  final bool isMoreDataAvailable;

  /// Loading widget at the bottom
  final Widget? loadingWidget;

  const CustomListView({
    super.key,
    this.items,
    this.itemCount,
    required this.itemBuilder,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.separator,
    this.scrollDirection = Axis.vertical,
    this.onEndReached,
    this.isMoreDataAvailable = false,
    this.loadingWidget,
  });

  @override
  State<CustomListView<T>> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.isMoreDataAvailable && widget.onEndReached != null) {
        widget.onEndReached!();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;

    if (widget.items != null && widget.itemCount != null) {
      count = min(widget.items!.length, widget.itemCount!);
    } else if (widget.items != null) {
      count = widget.items!.length;
    } else if (widget.itemCount != null) {
      count = widget.itemCount!;
    }

    // agar more data hai toh ek extra item loader ke liye
    if (widget.isMoreDataAvailable) count++;

    if (widget.separator != null) {
      return ListView.separated(
        controller: _scrollController,
        physics: widget.physics,
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        itemCount: count,
        itemBuilder: (context, index) {
          if (index == count - 1 && widget.isMoreDataAvailable) {
            return widget.loadingWidget ??
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
          }
          return widget.itemBuilder(
              context, index, widget.items != null ? widget.items![index] : null);
        },
        separatorBuilder: (context, index) => widget.separator!,
      );
    } else {
      return ListView.builder(
        controller: _scrollController,
        physics: widget.physics,
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        itemCount: count,
        itemBuilder: (context, index) {
          if (index == count - 1 && widget.isMoreDataAvailable) {
            return widget.loadingWidget ??
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
          }
          return widget.itemBuilder(
              context, index, widget.items != null ? widget.items![index] : null);
        },
      );
    }
  }
}

