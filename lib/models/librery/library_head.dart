class LibraryHead1 {
  String? id;
  String? name;
  String? schemeName;
  String? type; // <-- add this

  LibraryHead1({this.id, this.name, this.schemeName, this.type});

  factory LibraryHead1.fromJson(Map<String, dynamic> json) {
    return LibraryHead1(
      id: json['id'] as String?,
      name: json['name'] as String?,
      schemeName: json['scheme_name'] as String?,
      // Try to get type from backend or derive from name
      type: json['type'] as String? ?? _deriveTypeFromName(json['name'] as String? ?? ''),
    );
  }

  // Helper to derive type if backend doesn't provide it
  static String _deriveTypeFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('.pdf')) return 'pdf';
    if (lower.contains('.jpg') || lower.contains('.jpeg') || lower.contains('.png')) return 'image';
    if (lower.contains('.mp4') || lower.contains('.mov')) return 'video';
    if (lower.contains('.ppt') || lower.contains('.pptx')) return 'ppt';
    if (lower.contains('map') || lower.contains('location')) return 'location';
    return 'default';
  }
}
