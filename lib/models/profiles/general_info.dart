class GeneralInfoModel {
  String? actiontype;
  String? name;
  String? fatherName;
  String? motherName;
  String? spouseName;
  String? email;
  String? phone1;
  String? date;
  String? month;
  String? year;
  String? gender;
  String? nomineeRelation;
  String? nomineeName;

  GeneralInfoModel(
      {this.actiontype,
        this.name,
        this.fatherName,
        this.motherName,
        this.spouseName,
        this.email,
        this.phone1,
        this.date,
        this.month,
        this.year,
        this.gender,
        this.nomineeRelation,
        this.nomineeName});

  GeneralInfoModel.fromJson(Map<String, dynamic> json) {
    actiontype = json['actiontype'];
    name = json['name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    spouseName = json['spouse_name'];
    email = json['email'];
    phone1 = json['phone_1'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    gender = json['gender'];
    nomineeRelation = json['nominee_relation'];
    nomineeName = json['nominee_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actiontype'] = this.actiontype;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['spouse_name'] = this.spouseName;
    data['email'] = this.email;
    data['phone_1'] = this.phone1;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['gender'] = this.gender;
    data['nominee_relation'] = this.nomineeRelation;
    data['nominee_name'] = this.nomineeName;
    return data;
  }
}
