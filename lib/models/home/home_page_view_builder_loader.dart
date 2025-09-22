
import '../../core/constants/api_constants.dart';

class HomePageViewBuilderLoader {
  String? imageUrl;
  String? base64Image;

  HomePageViewBuilderLoader({this.imageUrl, this.base64Image});

  HomePageViewBuilderLoader.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    base64Image = json['base64_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['base64_image'] = base64Image;
    return data;
  }
  String get fullImageUrl {
    if (imageUrl == null || imageUrl!.isEmpty) return '';
    return '${ApiConstants1.imagePath}$imageUrl';
  }
}
