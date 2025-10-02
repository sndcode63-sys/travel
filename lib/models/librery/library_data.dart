
import '../../core/constants/api_constants.dart';

import '../../core/constants/api_constants.dart';

class LibraryDataModel {
  int? id;
  int? userId;
  String? content;
  String? urlLink;
  int? schemeId;
  int? libraryHeadNameId;
  int? librarydataId;
  String? images;
  String? schemeName;
  String? libraryHeadName;
  String? createdAt;

  LibraryDataModel({
    this.id,
    this.userId,
    this.content,
    this.urlLink,
    this.schemeId,
    this.libraryHeadNameId,
    this.librarydataId,
    this.images,
    this.schemeName,
    this.libraryHeadName,
    this.createdAt,
  });

  factory LibraryDataModel.fromJson(Map<String, dynamic> json) {
    return LibraryDataModel(
      id: json['id'],
      userId: json['user_id'],
      content: json['content']?.toString(),
      urlLink: json['url_link']?.toString(),
      schemeId: json['scheme_id'],
      libraryHeadNameId: json['library_head_name_id'],
      librarydataId: json['librarydata_id'],
      images: json['images']?.toString(),
      schemeName: json['scheme_name']?.toString(),
      libraryHeadName: json['library_head_name']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['content'] = content;
    data['url_link'] = urlLink;
    data['scheme_id'] = schemeId;
    data['library_head_name_id'] = libraryHeadNameId;
    data['librarydata_id'] = librarydataId;
    data['images'] = images;
    data['scheme_name'] = schemeName;
    data['library_head_name'] = libraryHeadName;
    data['created_at'] = createdAt;
    return data;
  }
  /// Full URL for PDF
  String? get fullPdfUrl {
    if (urlLink != null && urlLink!.toLowerCase().endsWith(".pdf")) {
      return "${ApiConstants1.imagePath}$urlLink";
    }
    if (images != null && images!.toLowerCase().endsWith(".pdf")) {
      return "${ApiConstants1.imagePath}$images";
    }
    return null;
  }

  /// Full URL for video
  String? get fullVideoUrl {
    if (images != null && images!.toLowerCase().endsWith(".mp4")) {
      return "${ApiConstants1.imagePath}$images";
    }
    return null;
  }

  String get fullImageUrl => ApiConstants1.imagePath;

}
