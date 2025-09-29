
class LibreryList {
  final int? schemeNumber; // Ya schemeName
  final String? name; // Yeh display name hai
  final String? id;

  LibreryList({this.schemeNumber, this.name, this.id});

  factory LibreryList.fromJson(Map<String, dynamic> json) {
    return LibreryList(
      schemeNumber: json['scheme_name'] as int?, // JSON key: 'scheme_name'
      name: json['name'] as String?,             // JSON key: 'name'
      id: json['id'] as String?,
    );
  }
}