
class TeamSelfModel {
  final int id;
  final String name;
  final String associateCode;
  final String? reraNo;

  TeamSelfModel({
    required this.id,
    required this.name,
    required this.associateCode,
    this.reraNo,
  });

  factory TeamSelfModel.fromJson(Map<String, dynamic> json) {
    return TeamSelfModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      associateCode: json['associate_code'] ?? "",
      reraNo: json['rera_no']?.toString(),
    );
  }
}
