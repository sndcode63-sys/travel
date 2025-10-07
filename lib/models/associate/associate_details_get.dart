class AssociateDetailsGet {
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
  String? phone2;
  String? whatsappnumber;
  String? aadharNumber;
  String? panNumber;
  String? reraNumber;
  String? reraApplicationNo;
  String? active;
  String? createdAt;
  int? teamName;
  String? teamname;
  String? pinName;
  String? pinname;
  String? uplinerName;
  String? uplinerReraNo;
  String? reraCertificate;
  String? aadharFrontFilename;
  String? bankCopyDocument;
  String? panCardFilename;
  String? passportFilename;
  String? passportNumber;
  String? locationName;
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
  String? profilePicSource;
  List<BankInfo>? bankInfo;

  AssociateDetailsGet({
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
    this.profilePicSource,
    this.bankInfo,
  });

  AssociateDetailsGet.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    associateCode = json['associate_code']?.toString();
    fullName = json['full_name']?.toString();
    fatherName = json['father_name']?.toString();
    motherName = json['mother_name']?.toString();
    spouseName = json['spouse_name']?.toString();
    dob = json['dob']?.toString();
    address = json['address']?.toString();
    city = json['city']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
    pincode = json['pincode']?.toString();
    email = json['email']?.toString();
    mobileNumber = json['mobile_number']?.toString();
    gender = json['gender']?.toString();
    phone2 = json['phone_2']?.toString();
    whatsappnumber = json['whatsappnumber']?.toString();
    aadharNumber = json['aadhar_number']?.toString();
    panNumber = json['pan_number']?.toString();
    reraNumber = json['rera_number']?.toString();
    reraApplicationNo = json['rera_application_no']?.toString();
    active = json['active']?.toString();
    createdAt = json['created_at']?.toString();
    teamName = json['team_name'] is int ? json['team_name'] : int.tryParse(json['team_name']?.toString() ?? '0');
    teamname = json['teamname']?.toString();
    pinName = json['pin_name']?.toString();
    pinname = json['pinname']?.toString();
    uplinerName = json['upliner_name']?.toString();
    uplinerReraNo = json['upliner_rera_no']?.toString();
    reraCertificate = json['rera_certificate']?.toString();
    aadharFrontFilename = json['aadhar_front_filename']?.toString();
    bankCopyDocument = json['bank_copy_document']?.toString();
    panCardFilename = json['pan_card_filename']?.toString();
    passportFilename = json['passport_filename']?.toString();
    passportNumber = json['passport_number']?.toString();
    locationName = json['location_name']?.toString();
    locationname = json['locationname']?.toString();
    nomineeName = json['nominee_name']?.toString();
    nomineeRelation = json['nominee_relation']?.toString();
    dateOfJoining = json['date_of_joining']?.toString();
    policeVerification = json['police_verification'] is int ? json['police_verification'] : int.tryParse(json['police_verification']?.toString() ?? '0');
    openingStock = json['opening_stock']?.toString();
    reraSerialName = json['rera_serial_name']?.toString();
    qualificationRemarks = json['qualification_remarks']?.toString();
    marksheetImage = json['marksheet_image']?.toString();
    reraImage = json['rera_image']?.toString();
    policeVerificationCopy = json['police_verification_copy']?.toString();
    reraSerial = json['rera_serial'] is int ? json['rera_serial'] : int.tryParse(json['rera_serial']?.toString() ?? '0');
    profilePic = json['profile_pic']?.toString();
    aadharImageSource = json['aadhar_image_source']?.toString();
    panImageSource = json['pan_image_source']?.toString();
    passportImageSource = json['passport_image_source']?.toString();
    qualificationRemarksImageSource = json['qualification_remarks_image_source']?.toString();
    reraImageSource = json['rera_image_source']?.toString();
    policeVerificationImageSource = json['police_verification_image_source']?.toString();
    bankCopyImageSource = json['bank_copy_image_source']?.toString();
    profilePicSource = json['profile_pic_source']?.toString();

    if (json['bank_info'] != null) {
      bankInfo = <BankInfo>[];
      json['bank_info'].forEach((v) {
        bankInfo!.add(BankInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['associate_code'] = associateCode;
    data['full_name'] = fullName;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['spouse_name'] = spouseName;
    data['dob'] = dob;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['gender'] = gender;
    data['phone_2'] = phone2;
    data['whatsappnumber'] = whatsappnumber;
    data['aadhar_number'] = aadharNumber;
    data['pan_number'] = panNumber;
    data['rera_number'] = reraNumber;
    data['rera_application_no'] = reraApplicationNo;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['team_name'] = teamName;
    data['teamname'] = teamname;
    data['pin_name'] = pinName;
    data['pinname'] = pinname;
    data['upliner_name'] = uplinerName;
    data['upliner_rera_no'] = uplinerReraNo;
    data['rera_certificate'] = reraCertificate;
    data['aadhar_front_filename'] = aadharFrontFilename;
    data['bank_copy_document'] = bankCopyDocument;
    data['pan_card_filename'] = panCardFilename;
    data['passport_filename'] = passportFilename;
    data['passport_number'] = passportNumber;
    data['location_name'] = locationName;
    data['locationname'] = locationname;
    data['nominee_name'] = nomineeName;
    data['nominee_relation'] = nomineeRelation;
    data['date_of_joining'] = dateOfJoining;
    data['police_verification'] = policeVerification;
    data['opening_stock'] = openingStock;
    data['rera_serial_name'] = reraSerialName;
    data['qualification_remarks'] = qualificationRemarks;
    data['marksheet_image'] = marksheetImage;
    data['rera_image'] = reraImage;
    data['police_verification_copy'] = policeVerificationCopy;
    data['rera_serial'] = reraSerial;
    data['profile_pic'] = profilePic;
    data['aadhar_image_source'] = aadharImageSource;
    data['pan_image_source'] = panImageSource;
    data['passport_image_source'] = passportImageSource;
    data['qualification_remarks_image_source'] = qualificationRemarksImageSource;
    data['rera_image_source'] = reraImageSource;
    data['police_verification_image_source'] = policeVerificationImageSource;
    data['bank_copy_image_source'] = bankCopyImageSource;
    data['profile_pic_source'] = profilePicSource;
    if (bankInfo != null) {
      data['bank_info'] = bankInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankInfo {
  int? id;
  String? ifscCode;
  String? bankName;
  String? accountNumber;
  String? accountType;

  BankInfo({this.id, this.ifscCode, this.bankName, this.accountNumber, this.accountType});

  BankInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0');
    ifscCode = json['ifsc_code']?.toString();
    bankName = json['bank_name']?.toString();
    accountNumber = json['account_number']?.toString();
    accountType = json['account_type']?.toString(); // Add this
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ifsc_code': ifscCode,
      'bank_name': bankName,
      'account_number': accountNumber,
      'account_type': accountType, // Add this
    };
  }
}
