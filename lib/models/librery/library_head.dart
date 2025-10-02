// ---------------------- MODEL ----------------------
class LibraryHead1 {
  String? id;
  String? name;
  String? schemeName;
  String? type;

  LibraryHead1({this.id, this.name, this.schemeName, this.type});

  factory LibraryHead1.fromJson(Map<String, dynamic> json) {
    return LibraryHead1(
      id: json['id'] as String?,
      name: json['name'] as String?,
      schemeName: json['scheme_name'] as String?,
      type: json['type'] as String?,
    );
  }
}
