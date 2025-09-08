import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


/// CUSTOM ZOOMING WIDGETS
class UltimateProfileZoom extends StatelessWidget {
  final String imageUrl;
  final String heroTag;
  final double size;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholderWidget;
  final Color placeholderColor;
  final bool enableZoom;
  final bool enableShadow;
  final Color? backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final Duration tapAnimationDuration;

  const UltimateProfileZoom({
    super.key,
    required this.imageUrl,
    required this.heroTag,
    this.size = 60.0,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderWidget,
    this.placeholderColor = Colors.grey,
    this.enableZoom = true,
    this.enableShadow = false,
    this.backgroundColor,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.tapAnimationDuration = const Duration(milliseconds: 150),
  });

  void _openZoom(BuildContext context) {
    if (!enableZoom) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: backgroundColor ?? Colors.black,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Hero(
                tag: heroTag,
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                  backgroundDecoration:
                  BoxDecoration(color: backgroundColor ?? Colors.black),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  enableRotation: true,
                  heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openZoom(context),
      child: AnimatedContainer(
        duration: tapAnimationDuration,
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
          color: backgroundColor ?? Colors.transparent,
          boxShadow: enableShadow
              ? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ]
              : [],
          border: borderWidth > 0
              ? Border.all(color: borderColor, width: borderWidth)
              : null,
        ),
        child: Hero(
          tag: heroTag,
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
            child: Image.network(
              imageUrl,
              width: size,
              height: size,
              fit: fit,
              errorBuilder: (_, __, ___) => placeholderWidget ??
                  Container(
                    width: size,
                    height: size,
                    color: placeholderColor,
                    child: Icon(Icons.person, size: size * 0.5),
                  ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: size,
                  height: size,
                  color: placeholderColor.withAlpha(76),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
