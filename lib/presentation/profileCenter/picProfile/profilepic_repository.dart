import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import 'dart:io';
import 'dart:convert';

import '../../../models/profiles/profile_pic_update.dart';

import 'package:image/image.dart' as img;


class ProfileRepository {
  static final _apiServices = ApiServices();

  // Compress image to reduce size
  static Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return file;

    final compressedBytes = img.encodeJpg(image, quality: 70); // 70% quality
    final tempFile = File(file.path)..writeAsBytesSync(compressedBytes);
    return tempFile;
  }

  static Future<ProfilePicUpdate> uploadProfilePic({required File file}) async {
    final compressedFile = await compressImage(file);
    final bytes = await compressedFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    // DEBUG: Log request
    print("Uploading profile pic, size: ${bytes.length} bytes");


    return await _apiServices.post<ProfilePicUpdate>(
      ApiConstants1.updateAssociateProfile,
          (json) => ProfilePicUpdate.fromJson(json),
      data: {
        "actiontype": "profilepic-information",
        "profile_pic": base64Image,
      },
    );
  }
}

