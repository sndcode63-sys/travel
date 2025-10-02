class Getbankmodel {
  int? status;
  String? bank;
  String? ifscCode;
  String? accountNumber;
  String? accountType;

  Getbankmodel(
      {this.status,
        this.bank,
        this.ifscCode,
        this.accountNumber,
        this.accountType});

  Getbankmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bank = json['bank_name'];
    ifscCode = json['ifsc_code'];
    accountNumber = json['account_number'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['bank_name'] = bank;
    data['ifsc_code'] = ifscCode;
    data['account_number'] = accountNumber;
    data['account_type'] = accountType;
    return data;
  }
}
