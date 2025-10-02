class BankInfoModel {
  String? actiontype;
  String? ifscCode;
  String? bankName;
  String? accountNumber;
  String? accountType;

  BankInfoModel(
      {this.actiontype, this.ifscCode, this.bankName, this.accountNumber,this.accountType});

  BankInfoModel.fromJson(Map<String, dynamic> json) {
    actiontype = json['actiontype'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actiontype'] = actiontype;
    data['ifsc_code'] = ifscCode;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_type'] = accountType;
    return data;
  }
}
