import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../storage/secure_local_storage_service.dart';

/// 🔹 Custom Network Image Widget with caching
class CustomNetworkImage extends StatefulWidget {
  final String imageUrl;
  final String cacheKey;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.cacheKey,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  CustomNetworkImageState createState() => CustomNetworkImageState();
}

class CustomNetworkImageState extends State<CustomNetworkImage> {
  late Future<File?> _imageFile;

  static final CacheManager _cacheManager = CacheManager(
    Config(
      'CustomNetworkImageCache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: 'CustomNetworkImageDB'),
      fileService: HttpFileService(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _imageFile = _loadImage();
  }

  Future<File?> _loadImage() async {
    // Try local secure cache first
    final localBytes = SecureLocalStorageService().read(widget.cacheKey);
    if (localBytes != null) {
      final dir = await Directory.systemTemp.createTemp();
      final file = File('${dir.path}/${widget.cacheKey}.jpg');
      await file.writeAsBytes(localBytes);
      return file;
    }

    // Load from network with cache manager
    try {
      final file = await _cacheManager.getSingleFile(widget.imageUrl);
      // Save to secure local storage
      final bytes = await file.readAsBytes();
      await SecureLocalStorageService().write(widget.cacheKey, bytes);
      return file;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: _imageFile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.placeholder ??
              SizedBox(width: widget.width, height: widget.height);
        }
        if (snapshot.hasData) {
          return Image.file(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        }
        return widget.errorWidget ??
            Icon(Icons.broken_image, size: widget.width);
      },
    );
  }
}
