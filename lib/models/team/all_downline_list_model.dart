
class AllDownlineListModel {
  int? id;
  String? associateCode;
  String? name;
  int? level;
  String? reraNo;
  int? sponsorId;
  String? sponsorCode;
  String? sponsorName;
  String? sponsorReraNo;

  AllDownlineListModel(
      {this.id,
        this.associateCode,
        this.name,
        this.level,
        this.reraNo,
        this.sponsorId,
        this.sponsorCode,
        this.sponsorName,
        this.sponsorReraNo});

  AllDownlineListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associateCode = json['associate_code'];
    name = json['name'];
    level = json['level'];
    reraNo = json['rera_no'];
    sponsorId = json['sponsor_id'];
    sponsorCode = json['sponsor_code'];
    sponsorName = json['sponsor_name'];
    sponsorReraNo = json['sponsor_rera_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['associate_code'] = associateCode;
    data['name'] = name;
    data['level'] = level;
    data['rera_no'] = reraNo;
    data['sponsor_id'] = sponsorId;
    data['sponsor_code'] = sponsorCode;
    data['sponsor_name'] = sponsorName;
    data['sponsor_rera_no'] = sponsorReraNo;
    return data;
  }
}
