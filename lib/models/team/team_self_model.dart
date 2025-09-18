
class TeamSelfModel {
  int? id;
  String? name;
  String? associateCode;
  Null reraNo;

  TeamSelfModel({this.id, this.name, this.associateCode, this.reraNo});

  TeamSelfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    associateCode = json['associate_code'];
    reraNo = json['rera_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['associate_code'] = this.associateCode;
    data['rera_no'] = this.reraNo;
    return data;
  }
}
