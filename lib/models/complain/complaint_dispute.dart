class Data {
  String? associateName;
  String? caseInDetails;
  String? disputeReason;
  String? disputeType;
  String? plotName;
  String? schemeName;
  String? staffName;
  String? subject;

  Data(
      {this.associateName,
        this.caseInDetails,
        this.disputeReason,
        this.disputeType,
        this.plotName,
        this.schemeName,
        this.staffName,
        this.subject});

  Data.fromJson(Map<String, dynamic> json) {
    associateName = json['associate_name'];
    caseInDetails = json['case_in_details'];
    disputeReason = json['dispute_reason'];
    disputeType = json['dispute_type'];
    plotName = json['plot_name'];
    schemeName = json['scheme_name'];
    staffName = json['staff_name'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['associate_name'] = this.associateName;
    data['case_in_details'] = this.caseInDetails;
    data['dispute_reason'] = this.disputeReason;
    data['dispute_type'] = this.disputeType;
    data['plot_name'] = this.plotName;
    data['scheme_name'] = this.schemeName;
    data['staff_name'] = this.staffName;
    data['subject'] = this.subject;
    return data;
  }
}
class ComplaintDispute {
  int? status;
  List<Data>? data;
  String? message;

  ComplaintDispute({this.status, this.data, this.message});

  ComplaintDispute.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}