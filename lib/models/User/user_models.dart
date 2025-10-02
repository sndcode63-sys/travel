import '../../core/constants/api_constants.dart';

class UserModels {
  String? identifier;
  String? name;
  String? email;
  String? associateCode;
  String? mobileNumber;
  String? status;
  String? uuid;
  String? teamName;
  String? pinName;
  String? locationName;
  String? uplinerName;
  String? firebaseToken;
  String? aadharNumber;
  String? panNumber;
  int? emailVerifyStatus;
  int? phoneVerifyStatus;
  int? aadharVerifyStatus;
  int? panVerifyStatus;
  String? profilePic;

  String? fatherName;
  String? motherName;
  String? spouseName;
  String? gender;
  String? nomineeName;
  String? nomineeRelation;
  int? dobDay;
  int? dobMonth;
  int? dobYear;

  UserModels({
    this.identifier,
    this.name,
    this.email,
    this.associateCode,
    this.mobileNumber,
    this.status,
    this.uuid,
    this.teamName,
    this.pinName,
    this.locationName,
    this.uplinerName,
    this.firebaseToken,
    this.aadharNumber,
    this.panNumber,
    this.emailVerifyStatus,
    this.phoneVerifyStatus,
    this.aadharVerifyStatus,
    this.panVerifyStatus,
    this.profilePic,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.gender,
    this.nomineeName,
    this.nomineeRelation,
    this.dobDay,
    this.dobMonth,
    this.dobYear,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
    identifier: json['identifier'],
    name: json['name'],
    email: json['email'],
    associateCode: json['associate_code'],
    mobileNumber: json['mobile_number'],
    status: json['status'],
    uuid: json['uuid'],
    teamName: json['team_name'],
    pinName: json['pin_name'],
    locationName: json['location_name'],
    uplinerName: json['upliner_name'],
    firebaseToken: json['firebase_token'],
    aadharNumber: json['aadhar_number'],
    panNumber: json['pan_number'],
    emailVerifyStatus: json['email_verify_status'],
    phoneVerifyStatus: json['phone_verify_status'],
    aadharVerifyStatus: json['aadhar_verify_status'],
    panVerifyStatus: json['pan_verify_status'],
    profilePic: json['profile_pic'],
    fatherName: json['father_name'],
    motherName: json['mother_name'],
    spouseName: json['spouse_name'],
    gender: json['gender'],
    nomineeName: json['nominee_name'],
    nomineeRelation: json['nominee_relation'],
    dobDay: json['dob_day'],
    dobMonth: json['dob_month'],
    dobYear: json['dob_year'],
  );

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'name': name,
    'email': email,
    'associate_code': associateCode,
    'mobile_number': mobileNumber,
    'status': status,
    'uuid': uuid,
    'team_name': teamName,
    'pin_name': pinName,
    'location_name': locationName,
    'upliner_name': uplinerName,
    'firebase_token': firebaseToken,
    'aadhar_number': aadharNumber,
    'pan_number': panNumber,
    'email_verify_status': emailVerifyStatus,
    'phone_verify_status': phoneVerifyStatus,
    'aadhar_verify_status': aadharVerifyStatus,
    'pan_verify_status': panVerifyStatus,
    'profile_pic': profilePic,
    'father_name': fatherName,
    'mother_name': motherName,
    'spouse_name': spouseName,
    'gender': gender,
    'nominee_name': nomineeName,
    'nominee_relation': nomineeRelation,
    'dob_day': dobDay,
    'dob_month': dobMonth,
    'dob_year': dobYear,
  };
  String get fullImageUrl => ApiConstants1.imagePath;

}
