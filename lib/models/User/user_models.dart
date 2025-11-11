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
    identifier: json['identifier']?.toString(),
    name: json['name']?.toString(),
    email: json['email']?.toString(),
    associateCode: json['associate_code']?.toString(),
    mobileNumber: json['mobile_number']?.toString(),
    status: json['status']?.toString(),
    uuid: json['uuid']?.toString(),
    teamName: json['team_name']?.toString(),
    pinName: json['pin_name']?.toString(),
    locationName: json['location_name']?.toString(),
    uplinerName: json['upliner_name']?.toString(),
    firebaseToken: json['firebase_token']?.toString(),
    aadharNumber: json['aadhar_number']?.toString(),
    panNumber: json['pan_number']?.toString(),
    emailVerifyStatus: json['email_verify_status'] is String
        ? int.tryParse(json['email_verify_status'])
        : json['email_verify_status'],
    phoneVerifyStatus: json['phone_verify_status'] is String
        ? int.tryParse(json['phone_verify_status'])
        : json['phone_verify_status'],
    aadharVerifyStatus: json['aadhar_verify_status'] is String
        ? int.tryParse(json['aadhar_verify_status'])
        : json['aadhar_verify_status'],
    panVerifyStatus: json['pan_verify_status'] is String
        ? int.tryParse(json['pan_verify_status'])
        : json['pan_verify_status'],
    profilePic: json['profile_pic']?.toString(),
    fatherName: json['father_name']?.toString(),
    motherName: json['mother_name']?.toString(),
    spouseName: json['spouse_name']?.toString(),
    gender: json['gender']?.toString(),
    nomineeName: json['nominee_name']?.toString(),
    nomineeRelation: json['nominee_relation']?.toString(),
    dobDay: json['dob_day'] is String
        ? int.tryParse(json['dob_day'])
        : json['dob_day'],
    dobMonth: json['dob_month'] is String
        ? int.tryParse(json['dob_month'])
        : json['dob_month'],
    dobYear: json['dob_year'] is String
        ? int.tryParse(json['dob_year'])
        : json['dob_year'],
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

  //  Helper: Full image path if profilePic exists
  String get fullImageUrl => "${ApiConstants1.imagePath}${profilePic ?? ''}";
}
