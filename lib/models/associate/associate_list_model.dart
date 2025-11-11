import '../../core/constants/api_constants.dart';

class AssociateListModel {
  String? id;
  String? associateCode;
  String? fullName;
  String? fatherName;
  String? motherName;
  String? spouseName;
  String? dob;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? email;
  String? mobileNumber;
  String? gender;
  dynamic phone2;
  dynamic whatsappnumber;
  String? aadharNumber;
  String? panNumber;
  String? reraNumber;
  String? reraApplicationNo;
  String? active;
  String? createdAt;
  int? teamName;
  String? teamname;
  int? pinName;
  String? pinname;
  String? uplinerName;
  String? uplinerReraNo;
  String? reraCertificate;
  String? aadharFrontFilename;
  String? bankCopyDocument;
  String? panCardFilename;
  String? passportFilename;
  String? passportNumber;
  int? locationName;
  String? locationname;
  String? nomineeName;
  String? nomineeRelation;
  String? dateOfJoining;
  int? policeVerification;
  String? openingStock;
  String? reraSerialName;
  String? qualificationRemarks;
  String? marksheetImage;
  String? reraImage;
  String? policeVerificationCopy;
  int? reraSerial;
  String? profilePic;
  String? aadharImageSource;
  String? panImageSource;
  String? passportImageSource;
  String? qualificationRemarksImageSource;
  String? reraImageSource;
  String? policeVerificationImageSource;
  String? bankCopyImageSource;
  List<BankInfo>? bankInfo;
  int? status;
  String? message;

  AssociateListModel({
    this.id,
    this.associateCode,
    this.fullName,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.dob,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.email,
    this.mobileNumber,
    this.gender,
    this.phone2,
    this.whatsappnumber,
    this.aadharNumber,
    this.panNumber,
    this.reraNumber,
    this.reraApplicationNo,
    this.active,
    this.createdAt,
    this.teamName,
    this.teamname,
    this.pinName,
    this.pinname,
    this.uplinerName,
    this.uplinerReraNo,
    this.reraCertificate,
    this.aadharFrontFilename,
    this.bankCopyDocument,
    this.panCardFilename,
    this.passportFilename,
    this.passportNumber,
    this.locationName,
    this.locationname,
    this.nomineeName,
    this.nomineeRelation,
    this.dateOfJoining,
    this.policeVerification,
    this.openingStock,
    this.reraSerialName,
    this.qualificationRemarks,
    this.marksheetImage,
    this.reraImage,
    this.policeVerificationCopy,
    this.reraSerial,
    this.profilePic,
    this.aadharImageSource,
    this.panImageSource,
    this.passportImageSource,
    this.qualificationRemarksImageSource,
    this.reraImageSource,
    this.policeVerificationImageSource,
    this.bankCopyImageSource,
    this.bankInfo,
    this.message,
    this.status
  });

  AssociateListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json["id"];
    associateCode = json["associate_code"];
    fullName = json["full_name"];
    fatherName = json["father_name"];
    motherName = json["mother_name"];
    spouseName = json["spouse_name"];
    dob = json["dob"];
    address = json["address"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    pincode = json["pincode"];
    email = json["email"];
    mobileNumber = json["mobile_number"];
    gender = json["gender"];
    phone2 = json["phone_2"];
    whatsappnumber = json["whatsappnumber"];
    aadharNumber = json["aadhar_number"];
    panNumber = json["pan_number"];
    reraNumber = json["rera_number"];
    reraApplicationNo = json["rera_application_no"];
    active = json["active"];
    createdAt = json["created_at"];
    teamName = json["team_name"];
    teamname = json["teamname"];
    pinName = json["pin_name"];
    pinname = json["pinname"];
    uplinerName = json["upliner_name"];
    uplinerReraNo = json["upliner_rera_no"];
    reraCertificate = json["rera_certificate"];
    aadharFrontFilename = json["aadhar_front_filename"];
    bankCopyDocument = json["bank_copy_document"];
    panCardFilename = json["pan_card_filename"];
    passportFilename = json["passport_filename"];
    passportNumber = json["passport_number"];
    locationName = json["location_name"];
    locationname = json["locationname"];
    nomineeName = json["nominee_name"];
    nomineeRelation = json["nominee_relation"];
    dateOfJoining = json["date_of_joining"];
    policeVerification = json["police_verification"];
    openingStock = json["opening_stock"];
    reraSerialName = json["rera_serial_name"];
    qualificationRemarks = json["qualification_remarks"];
    marksheetImage = json["marksheet_image"];
    reraImage = json["rera_image"];
    policeVerificationCopy = json["police_verification_copy"];
    reraSerial = json["rera_serial"];
    profilePic = json["profile_pic"];
    aadharImageSource = json["aadhar_image_source"];
    panImageSource = json["pan_image_source"];
    passportImageSource = json["passport_image_source"];
    qualificationRemarksImageSource =
        json["qualification_remarks_image_source"];
    reraImageSource = json["rera_image_source"];
    policeVerificationImageSource = json["police_verification_image_source"];
    bankCopyImageSource = json["bank_copy_image_source"];
    bankInfo =
        json["bank_info"] == null
            ? null
            : (json["bank_info"] as List)
                .map((e) => BankInfo.fromJson(e))
                .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["associate_code"] = associateCode;
    _data["full_name"] = fullName;
    _data["father_name"] = fatherName;
    _data["mother_name"] = motherName;
    _data["spouse_name"] = spouseName;
    _data["dob"] = dob;
    _data["address"] = address;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["pincode"] = pincode;
    _data["email"] = email;
    _data["mobile_number"] = mobileNumber;
    _data["gender"] = gender;
    _data["phone_2"] = phone2;
    _data["whatsappnumber"] = whatsappnumber;
    _data["aadhar_number"] = aadharNumber;
    _data["pan_number"] = panNumber;
    _data["rera_number"] = reraNumber;
    _data["rera_application_no"] = reraApplicationNo;
    _data["active"] = active;
    _data["created_at"] = createdAt;
    _data["team_name"] = teamName;
    _data["teamname"] = teamname;
    _data["pin_name"] = pinName;
    _data["pinname"] = pinname;
    _data["upliner_name"] = uplinerName;
    _data["upliner_rera_no"] = uplinerReraNo;
    _data["rera_certificate"] = reraCertificate;
    _data["aadhar_front_filename"] = aadharFrontFilename;
    _data["bank_copy_document"] = bankCopyDocument;
    _data["pan_card_filename"] = panCardFilename;
    _data["passport_filename"] = passportFilename;
    _data["passport_number"] = passportNumber;
    _data["location_name"] = locationName;
    _data["locationname"] = locationname;
    _data["nominee_name"] = nomineeName;
    _data["nominee_relation"] = nomineeRelation;
    _data["date_of_joining"] = dateOfJoining;
    _data["police_verification"] = policeVerification;
    _data["opening_stock"] = openingStock;
    _data["rera_serial_name"] = reraSerialName;
    _data["qualification_remarks"] = qualificationRemarks;
    _data["marksheet_image"] = marksheetImage;
    _data["rera_image"] = reraImage;
    _data["police_verification_copy"] = policeVerificationCopy;
    _data["rera_serial"] = reraSerial;
    _data["profile_pic"] = profilePic;
    _data["aadhar_image_source"] = aadharImageSource;
    _data["pan_image_source"] = panImageSource;
    _data["passport_image_source"] = passportImageSource;
    _data["qualification_remarks_image_source"] =
        qualificationRemarksImageSource;
    _data["rera_image_source"] = reraImageSource;
    _data["police_verification_image_source"] = policeVerificationImageSource;
    _data["bank_copy_image_source"] = bankCopyImageSource;
    if (bankInfo != null) {
      _data["bank_info"] = bankInfo?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
  String get fullImageUrl => ApiConstants1.imagePath;

}

class BankInfo {
  int? id;
  String? ifscCode;
  String? bankName;
  String? accountNumber;

  BankInfo({this.id, this.ifscCode, this.bankName, this.accountNumber});

  BankInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ifscCode = json["ifsc_code"];
    bankName = json["bank_name"];
    accountNumber = json["account_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ifsc_code"] = ifscCode;
    _data["bank_name"] = bankName;
    _data["account_number"] = accountNumber;
    return _data;
  }

}
