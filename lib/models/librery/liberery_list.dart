
class LibreryList {
  int? schemeName;
  String? name;
  String? id;

  LibreryList({this.schemeName, this.name, this.id});

  LibreryList.fromJson(Map<String, dynamic> json) {
    schemeName = json['scheme_name'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheme_name'] = schemeName;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
