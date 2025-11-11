import '../../core/constants/api_constants.dart';

class SuggestionGetListModel {
  String? id;
  String? content;
  String? photo;
  String? status;
  String? createdAt;
  String? base64Image;
  String? timeAgo;
  String? message;

  SuggestionGetListModel({
    this.id,
    this.content,
    this.photo,
    this.status,
    this.createdAt,
    this.base64Image,
    this.timeAgo,
    this.message,
  });

  SuggestionGetListModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    content = json["content"];
    photo = json["photo"];
    status = json["status"];
    createdAt = json["created_at"];
    base64Image = json["base64_image"];
    timeAgo = json["time_ago"];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["content"] = content;
    data["photo"] = photo;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["base64_image"] = base64Image;
    data["time_ago"] = timeAgo;
    return data;
  }

  String get fullImageUrl => ApiConstants1.imagePath;

}
