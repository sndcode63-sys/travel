
class AddMeetingModel {
  String? noOfUsers;
  String? reference;
  String? latitute;
  String? longitude;
  String? meetingImage;

  AddMeetingModel(
      {this.noOfUsers,
        this.reference,
        this.latitute,
        this.longitude,
        this.meetingImage,});

  AddMeetingModel.fromJson(Map<String, dynamic> json) {
    noOfUsers = json['no_of_users'];
    reference = json['reference'];
    latitute = json['latitute'];
    longitude = json['longitude'];
    meetingImage = json['meeting_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_of_users'] = this.noOfUsers;
    data['reference'] = this.reference;
    data['latitute'] = this.latitute;
    data['longitude'] = this.longitude;
    data['meeting_image'] = this.meetingImage;
    return data;
  }
}
