
class Example {
  int? status;
  String? message;
  List<Data>? data;

  Example({this.status, this.message, this.data});

  Example.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  static List<Example> fromList(List<Map<String, dynamic>> list) {
    return list.map(Example.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? fromUserType;
  String? fromName;
  String? fromPhoneNumber;
  String? toUserType;
  String? toName;
  String? toPhoneNumber;
  String? id;
  dynamic disputeReason;
  String? subject;
  String? caseInDetails;
  String? lastStatus;
  String? entryRole;
  dynamic schemeName;
  dynamic plotName;
  String? disputeDate;

  Data({this.fromUserType, this.fromName, this.fromPhoneNumber, this.toUserType, this.toName, this.toPhoneNumber, this.id, this.disputeReason, this.subject, this.caseInDetails, this.lastStatus, this.entryRole, this.schemeName, this.plotName, this.disputeDate});

  Data.fromJson(Map<String, dynamic> json) {
    fromUserType = json["from_user_type"];
    fromName = json["FromName"];
    fromPhoneNumber = json["FromPhoneNumber"];
    toUserType = json["to_user_type"];
    toName = json["ToName"];
    toPhoneNumber = json["ToPhoneNumber"];
    id = json["id"];
    disputeReason = json["Dispute_Reason"];
    subject = json["subject"];
    caseInDetails = json["case_in_details"];
    lastStatus = json["last_status"];
    entryRole = json["entry_role"];
    schemeName = json["scheme_name"];
    plotName = json["plot_name"];
    disputeDate = json["dispute_date"];
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["from_user_type"] = fromUserType;
    _data["FromName"] = fromName;
    _data["FromPhoneNumber"] = fromPhoneNumber;
    _data["to_user_type"] = toUserType;
    _data["ToName"] = toName;
    _data["ToPhoneNumber"] = toPhoneNumber;
    _data["id"] = id;
    _data["Dispute_Reason"] = disputeReason;
    _data["subject"] = subject;
    _data["case_in_details"] = caseInDetails;
    _data["last_status"] = lastStatus;
    _data["entry_role"] = entryRole;
    _data["scheme_name"] = schemeName;
    _data["plot_name"] = plotName;
    _data["dispute_date"] = disputeDate;
    return _data;
  }
}