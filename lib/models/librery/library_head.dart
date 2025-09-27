
class LibraryHead {
  int? libraryHeadName;
  String? name;
  String? schemeName;
  String? id;

  LibraryHead({this.libraryHeadName, this.name, this.schemeName, this.id});

  LibraryHead.fromJson(Map<String, dynamic> json) {
    libraryHeadName = json['library_head_name'];
    name = json['name'];
    schemeName = json['scheme_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['library_head_name'] = libraryHeadName;
    data['name'] = name;
    data['scheme_name'] = schemeName;
    data['id'] = id;
    return data;
  }
}
