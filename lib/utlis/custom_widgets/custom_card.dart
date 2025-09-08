import 'package:flutter/material.dart';

/// CUSTOM CARDS
class CustomCard extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onTap;

  // Background
  final Color? color;
  final List<Color>? gradientColors;

  // Border
  final double borderRadius;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final Color? borderColor;
  final double borderWidth;

  // Shadow
  final List<BoxShadow>? boxShadow;

  // Padding & Margin
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  // Tap animation
  final bool enableScaleOnTap;
  final double scaleFactor;
  final Duration scaleDuration;

  const CustomCard({
    super.key,
    this.child,
    this.onTap,
    this.color = Colors.white,
    this.gradientColors,
    this.borderRadius = 12,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.borderColor,
    this.borderWidth = 0,
    this.boxShadow,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.all(8),
    this.enableScaleOnTap = true,
    this.scaleFactor = 0.97,
    this.scaleDuration = const Duration(milliseconds: 100),
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    if (widget.enableScaleOnTap) setState(() => _scale = widget.scaleFactor);
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enableScaleOnTap) setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    if (widget.enableScaleOnTap) setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(widget.topLeftRadius ?? widget.borderRadius),
      topRight: Radius.circular(widget.topRightRadius ?? widget.borderRadius),
      bottomLeft: Radius.circular(widget.bottomLeftRadius ?? widget.borderRadius),
      bottomRight: Radius.circular(widget.bottomRightRadius ?? widget.borderRadius),
    );

    return Container(
      margin: widget.margin,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: widget.scaleDuration,
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: Ink(
              decoration: BoxDecoration(
                color: widget.gradientColors == null ? widget.color : null,
                gradient: widget.gradientColors != null
                    ? LinearGradient(colors: widget.gradientColors!)
                    : null,
                borderRadius: borderRadius,
                border: widget.borderWidth > 0
                    ? Border.all(color: widget.borderColor ?? Colors.black12, width: widget.borderWidth)
                    : null,
                boxShadow: widget.boxShadow ??
                    [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
              ),
              child: Padding(
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//// used
// 1️⃣ Simple text card
// CustomCard(
// onTap: () => print("Card tapped!"),
// child: Text("Hello CustomCard"),
// )

// // 2️⃣ Gradient card with image and text
// CustomCard(
// gradientColors: [Colors.purple, Colors.blue],
// borderRadius: 16,
// child: Column(
// children: [
// Image.network('https://picsum.photos/200/100'),
// SizedBox(height: 8),
// Text("Gradient Card", style: TextStyle(color: Colors.white)),
// ],
// ),
// onTap: () => print("Gradient Card tapped!"),
// )
//
// // 3️⃣ Card with custom shadow & border
// CustomCard(
// borderRadius: 20,
// borderColor: Colors.red,
// borderWidth: 2,
// boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 8)],
// child: Padding(
// padding: EdgeInsets.all(20),
// child: Center(child: Text("Custom Shadow & Border")),
// ),
// )
