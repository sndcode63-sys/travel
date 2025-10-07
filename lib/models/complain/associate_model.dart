

class AssociateModel {
  String? id;
  String? name;
  String? phone;
  String? uplinerName;
  String? teamName;

  AssociateModel({this.id, this.name, this.phone, this.uplinerName, this.teamName});

  AssociateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    uplinerName = json['upliner_name'];
    teamName = json['team_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['upliner_name'] = uplinerName;
    data['team_name'] = teamName;
    return data;
  }
}
