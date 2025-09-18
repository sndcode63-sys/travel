class Data {
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
  Null uplinerName;
  String? firebaseToken;
  String? aadharNumber;
  String? panNumber;
  int? emailVerifyStatus;
  int? phoneVerifyStatus;
  int? aadharVerifyStatus;
  int? panVerifyStatus;
  String? profilePic;

  Data(
      {this.identifier,
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
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    name = json['name'];
    email = json['email'];
    associateCode = json['associate_code'];
    mobileNumber = json['mobile_number'];
    status = json['status'];
    uuid = json['uuid'];
    teamName = json['team_name'];
    pinName = json['pin_name'];
    locationName = json['location_name'];
    uplinerName = json['upliner_name'];
    firebaseToken = json['firebase_token'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    emailVerifyStatus = json['email_verify_status'];
    phoneVerifyStatus = json['phone_verify_status'];
    aadharVerifyStatus = json['aadhar_verify_status'];
    panVerifyStatus = json['pan_verify_status'];
    profilePic = json['profile_pic'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['name'] = name;
    data['email'] = email;
    data['associate_code'] = associateCode;
    data['mobile_number'] = mobileNumber;
    data['status'] = status;
    data['uuid'] = uuid;
    data['team_name'] = teamName;
    data['pin_name'] = pinName;
    data['location_name'] = locationName;
    data['upliner_name'] = uplinerName;
    data['firebase_token'] = firebaseToken;
    data['aadhar_number'] = aadharNumber;
    data['pan_number'] = panNumber;
    data['email_verify_status'] = emailVerifyStatus;
    data['phone_verify_status'] = phoneVerifyStatus;
    data['aadhar_verify_status'] = aadharVerifyStatus;
    data['pan_verify_status'] = panVerifyStatus;
    data['profile_pic'] = profilePic;
    return data;
  }
}
