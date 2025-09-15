class SaveVisitConte {
  String? clientFullName;
  String? emailAddress;
  String? fatherName;
  String? latitute;
  String? longitude;
  String? mobileNumber;
  String? remarks;
  String? schemeName;
  String? visitImage;

  SaveVisitConte(
      {this.clientFullName,
        this.emailAddress,
        this.fatherName,
        this.latitute,
        this.longitude,
        this.mobileNumber,
        this.remarks,
        this.schemeName,
        this.visitImage});

  SaveVisitConte.fromJson(Map<String, dynamic> json) {
    clientFullName = json['client_full_name'];
    emailAddress = json['email_address'];
    fatherName = json['father_name'];
    latitute = json['latitute'];
    longitude = json['longitude'];
    mobileNumber = json['mobile_number'];
    remarks = json['remarks'];
    schemeName = json['scheme_name'];
    visitImage = json['visit_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_full_name'] = clientFullName;
    data['email_address'] = emailAddress;
    data['father_name'] = fatherName;
    data['latitute'] = latitute;
    data['longitude'] = longitude;
    data['mobile_number'] = mobileNumber;
    data['remarks'] = remarks;
    data['scheme_name'] = schemeName;
    data['visit_image'] = visitImage;
    return data;
  }
}
