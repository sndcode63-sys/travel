class SaveSuggestionModel {
  String? message;
  String? fileSource;
  int? status;


  SaveSuggestionModel({this.message, this.fileSource,    this.status,
  });

  SaveSuggestionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fileSource = json['fileSource'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['fileSource'] = this.fileSource;
    return data;
  }
}
