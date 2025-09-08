import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import '../storage/secure_local_storage_service.dart';

class CustomLocalImage {
  CustomLocalImage._();
  static final instance = CustomLocalImage._();

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery/camera
  Future<File?> pickImage({bool fromCamera = false}) async {
    final pickedFile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  /// Compress image file
  Future<XFile?> compressFile(File file,
      {int quality = 70, int maxWidth = 1080, int maxHeight = 1080}) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
      minWidth: maxWidth,
      minHeight: maxHeight,
    );

    return result;
  }

  /// Pick, compress & cache
  Future<XFile?> pickCompressAndCache(String key,
      {bool fromCamera = false, int quality = 70, int maxWidth = 1080}) async {
    final picked = await pickImage(fromCamera: fromCamera);
    if (picked == null) return null;

    final compressed =
    await compressFile(picked, quality: quality, maxWidth: maxWidth);
    if (compressed != null) {
      final bytes = await compressed.readAsBytes();
      await SecureLocalStorageService().write(key, bytes);
    }
    return compressed;
  }

  /// Get cached file by key
  Future<File?> getCachedFile(String key) async {
    final bytes = SecureLocalStorageService().read(key);
    if (bytes == null) return null;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$key.jpg');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Return Image widget from cached file
  Future<Widget> getImageWidget(String key,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) async {
    final file = await getCachedFile(key);
    if (file != null) return Image.file(file, width: width, height: height, fit: fit);
    return SizedBox(width: width, height: height);
  }
}
