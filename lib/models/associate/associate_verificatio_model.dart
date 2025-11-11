class AssociateVerificatioModel {
  String? associateId;
  String? actiontype;
  String? passportNumber;
  String? reraCertificate;
  String? qualificationRemarks;
  String? policeVerification;
  String? aadharImage;
  String? panImage;
  String? passportImage;
  String? qualificationRemarksImage;
  String? reraImage;
  String? policeVerificationImage;
  String? bankCopyImage;
  int? status;
  String? message;

  AssociateVerificatioModel({
    this.associateId,
    this.actiontype,
    this.passportNumber,
    this.reraCertificate,
    this.qualificationRemarks,
    this.policeVerification,
    this.aadharImage,
    this.panImage,
    this.passportImage,
    this.qualificationRemarksImage,
    this.reraImage,
    this.policeVerificationImage,
    this.bankCopyImage,
    this.message,
    this.status
  });

  AssociateVerificatioModel.fromJson(Map<String, dynamic> json) {
    associateId = json["associate_id"];
    actiontype = json["actiontype"];
    passportNumber = json["passport_number"];
    reraCertificate = json["rera_certificate"];
    qualificationRemarks = json["qualification_remarks"];
    policeVerification = json["police_verification"];
    aadharImage = json["aadhar_image"];
    panImage = json["pan_image"];
    passportImage = json["passport_image"];
    qualificationRemarksImage = json["qualification_remarks_image"];
    reraImage = json["rera_image"];
    policeVerificationImage = json["police_verification_image"];
    bankCopyImage = json["bank_copy_image"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["associate_id"] = associateId;
    data["actiontype"] = actiontype;
    data["passport_number"] = passportNumber;
    data["rera_certificate"] = reraCertificate;
    data["qualification_remarks"] = qualificationRemarks;
    data["police_verification"] = policeVerification;
    data["aadhar_image"] = aadharImage;
    data["pan_image"] = panImage;
    data["passport_image"] = passportImage;
    data["qualification_remarks_image"] = qualificationRemarksImage;
    data["rera_image"] = reraImage;
    data["police_verification_image"] = policeVerificationImage;
    data["bank_copy_image"] = bankCopyImage;
    return data;
  }
}
