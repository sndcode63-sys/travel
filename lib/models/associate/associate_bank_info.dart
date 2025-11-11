class AssociateBankInfo {
  String? associateId;
  String? actiontype;
  String? ifscCode;
  String? bankName;
  String? accountNumber;
  String? accountType;
  int? status;
  String? message;

  AssociateBankInfo({
    this.associateId,
    this.actiontype,
    this.ifscCode,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.message,
    this.status
  });

  AssociateBankInfo.fromJson(Map<String, dynamic> json) {
    associateId = json["associate_id"];
    actiontype = json["actiontype"];
    ifscCode = json["ifsc_code"];
    bankName = json["bank_name"];
    accountNumber = json["account_number"];
    accountType = json["account_type"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["associate_id"] = associateId;
    data["actiontype"] = actiontype;
    data["ifsc_code"] = ifscCode;
    data["bank_name"] = bankName;
    data["account_number"] = accountNumber;
    data["account_type"] = accountType;
    return data;
  }
}
