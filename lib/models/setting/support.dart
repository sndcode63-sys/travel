
class Support {
  String? supportEmailAddress;
  String? supportContactNumber;

  Support({this.supportEmailAddress, this.supportContactNumber});

  Support.fromJson(Map<String, dynamic> json) {
    supportEmailAddress = json['support_email_address'];
    supportContactNumber = json['support_contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['support_email_address'] = supportEmailAddress;
    data['support_contact_number'] = supportContactNumber;
    return data;
  }
}
