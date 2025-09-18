class SchemeListData {
  int? schemeId;
  String? schemeName;
  String? id;

  SchemeListData({this.schemeId, this.schemeName, this.id});

  SchemeListData.fromJson(Map<String, dynamic> json) {
    schemeId = json['SchemeId'];
    schemeName = json['SchemeName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SchemeId'] = schemeId;
    data['SchemeName'] = schemeName;
    data['id'] = id;
    return data;
  }
}
