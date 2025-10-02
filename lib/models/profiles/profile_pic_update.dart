class ProfilePicUpdate {
  // Request fields
  String? actiontype;
  String? profilePic;
  String? associateCode;

  // Response fields
  int? status;
  String? message;

  ProfilePicUpdate({
    this.actiontype,
    this.profilePic,
    this.associateCode,
    this.status,
    this.message,
  });

  factory ProfilePicUpdate.fromJson(Map<String, dynamic> json) {
    return ProfilePicUpdate(
      actiontype: json['actiontype'],
      profilePic: json['profilePic'],
      associateCode: json['associateCode'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actiontype': actiontype,
      'profilePic': profilePic,
      'associateCode': associateCode,
    };
  }
}
