// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_picker/image_picker.dart';
// import '../storage/secure_local_storage_service.dart';
//
// /// 🔹 Full Image Helper for Production
// class ImageHelper {
//   ImageHelper._();
//   static final instance = ImageHelper._();
//
//   /// CacheManager for network images
//   static final CacheManager _cacheManager = CacheManager(
//     Config(
//       'AppImageCache',
//       stalePeriod: const Duration(days: 7),
//       maxNrOfCacheObjects: 200,
//       repo: JsonCacheInfoRepository(databaseName: 'AppImageCacheDB'),
//       fileService: HttpFileService(),
//     ),
//   );
//
//   final ImagePicker _picker = ImagePicker();
//
//   /// 🌐 Load network image with caching
//   Widget networkImage(
//       String url, {
//         BoxFit fit = BoxFit.cover,
//         double? width,
//         double? height,
//         Widget? placeholder,
//         Widget? errorWidget,
//       }) {
//     return Image(
//       image: CachedNetworkImageProvider(
//         url,
//         cacheManager: _cacheManager,
//       ),
//       fit: fit,
//       width: width,
//       height: height,
//       errorBuilder: (_, __, ___) => errorWidget ?? Icon(Icons.image_not_supported),
//     );
//   }
//
//   /// 📸 Pick image from gallery or camera
//   Future<File?> pickImage({bool fromCamera = false}) async {
//     final pickedFile = await _picker.pickImage(
//       source: fromCamera ? ImageSource.camera : ImageSource.gallery,
//     );
//     if (pickedFile == null) return null;
//     return File(pickedFile.path);
//   }
//
//   /// 🗜 Compress image file
//   Future<File?> compressFile(
//       File file, {
//         int quality = 70,
//         int maxWidth = 1080,
//         int maxHeight = 1080,
//       }) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//
//     final result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: quality,
//       minWidth: maxWidth,
//       minHeight: maxHeight,
//     );
//
//     return result;
//   }
//
//   /// 💾 Cache file securely with key
//   Future<void> cacheFile(String key, File file) async {
//     final bytes = await file.readAsBytes();
//     await SecureLocalStorageService().write(key, bytes);
//   }
//
//   /// 📂 Get cached file by key
//   Future<File?> getCachedFile(String key) async {
//     final bytes = SecureLocalStorageService().read(key);
//     if (bytes == null) return null;
//
//     final dir = await getTemporaryDirectory();
//     final file = File('${dir.path}/$key.jpg');
//     await file.writeAsBytes(bytes);
//     return file;
//   }
//
//   /// ❌ Clear specific cache
//   Future<void> clearCache(String key) async {
//     await SecureLocalStorageService().delete(key);
//     await _cacheManager.removeFile(key);
//   }
//
//   /// 🧹 Clear all caches (network + local)
//   Future<void> clearAll() async {
//     await SecureLocalStorageService().clear();
//     await _cacheManager.emptyCache();
//   }
//
//   /// 🔁 Pick, compress & cache in one go
//   Future<File?> pickCompressAndCache(String key,
//       {bool fromCamera = false, int quality = 70, int maxWidth = 1080}) async {
//     final picked = await pickImage(fromCamera: fromCamera);
//     if (picked == null) return null;
//
//     final compressed = await compressFile(picked, quality: quality, maxWidth: maxWidth);
//     if (compressed != null) await cacheFile(key, compressed);
//     return compressed;
//   }
//
//   /// 🖼 Get image widget from cache or network fallback
//   Widget cachedNetworkOrLocalImage(
//       String key,
//       String networkUrl, {
//         BoxFit fit = BoxFit.cover,
//         double? width,
//         double? height,
//         Widget? placeholder,
//         Widget? errorWidget,
//       }) {
//     return FutureBuilder<File?>(
//       future: getCachedFile(key),
//       builder: (_, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return placeholder ?? SizedBox(width: width, height: height);
//         }
//         if (snapshot.hasData) {
//           return Image.file(snapshot.data!, fit: fit, width: width, height: height);
//         }
//         return networkImage(
//           networkUrl,
//           fit: fit,
//           width: width,
//           height: height,
//           placeholder: placeholder,
//           errorWidget: errorWidget,
//         );
//       },
//     );
//   }
// }
