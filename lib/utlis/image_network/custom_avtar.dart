import 'dart:io';
import 'package:flutter/material.dart';
import 'custom_locall_image.dart';
import 'custom_network_image.dart';

class CustomAvatar extends StatelessWidget {
  final String? networkUrl;
  final String? localCacheKey;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final BoxShadow? shadow;
  final Widget? placeholder;

  const CustomAvatar({
    super.key,
    this.networkUrl,
    this.localCacheKey,
    this.radius = 30,
    this.borderColor = Colors.white,
    this.borderWidth = 2,
    this.shadow,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatarChild;

    // Priority: local cache > network > placeholder
    if (localCacheKey != null) {
      avatarChild = FutureBuilder<File?>(
        future: CustomLocalImage.instance.getCachedFile(localCacheKey!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return placeholder ??
                CircleAvatar(radius: radius, backgroundColor: Colors.grey[300]);
          }
          if (snapshot.hasData) {
            return CircleAvatar(radius: radius, backgroundImage: FileImage(snapshot.data!));
          }
          if (networkUrl != null) {
            return ClipOval(
              child: CustomNetworkImage(
                imageUrl: networkUrl!,
                cacheKey: localCacheKey!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
              ),
            );
          }
          return placeholder ??
              CircleAvatar(radius: radius, backgroundColor: Colors.grey[300]);
        },
      );
    } else if (networkUrl != null) {
      avatarChild = ClipOval(
        child: CustomNetworkImage(
          imageUrl: networkUrl!,
          cacheKey: networkUrl!, // fallback key
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      );
    } else {
      avatarChild = placeholder ??
          CircleAvatar(radius: radius, backgroundColor: Colors.grey[300]);
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: shadow != null ? [shadow!] : null,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: avatarChild,
    );
  }
}
