
import '../../core/constants/api_constants.dart';

class  MeetingList {
  int? id;
  int? userId;
  Null name;
  int? noOfUser;
  String? latitute;
  String? longitute;
  String? photo;
  String? reference;
  String? submitDate;
  String? submitTime;
  int? active;
  Null imagefile;
  String? meetingStatus;
  Null reason;
  String? deviceDetails;
  String? submittedBy;
  String? createdAt;
  String? updatedAt;
  Null base64;
  Null entryBy;
  String? averageBrightness;
  Null oldUserId;
  Null lastUpdateDatetime;
  Null deletedAt;
  String? visitStatus;
  String? base64Image;

  MeetingList(
      {this.id,
        this.userId,
        this.name,
        this.noOfUser,
        this.latitute,
        this.longitute,
        this.photo,
        this.reference,
        this.submitDate,
        this.submitTime,
        this.active,
        this.imagefile,
        this.meetingStatus,
        this.reason,
        this.deviceDetails,
        this.submittedBy,
        this.createdAt,
        this.updatedAt,
        this.base64,
        this.entryBy,
        this.averageBrightness,
        this.oldUserId,
        this.lastUpdateDatetime,
        this.deletedAt,
        this.visitStatus,
        this.base64Image});

  MeetingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    noOfUser = json['no_of_user'];
    latitute = json['latitute'];
    longitute = json['longitute'];
    photo = json['photo'];
    reference = json['reference'];
    submitDate = json['submit_date'];
    submitTime = json['submit_time'];
    active = json['active'];
    imagefile = json['imagefile'];
    meetingStatus = json['meeting_status'];
    reason = json['reason'];
    deviceDetails = json['device_details'];
    submittedBy = json['submitted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    base64 = json['base64'];
    entryBy = json['entry_by'];
    averageBrightness = json['averageBrightness'];
    oldUserId = json['old_user_id'];
    lastUpdateDatetime = json['last_update_datetime'];
    deletedAt = json['deleted_at'];
    visitStatus = json['visit_status'];
    base64Image = json['base64_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['no_of_user'] = noOfUser;
    data['latitute'] = latitute;
    data['longitute'] = longitute;
    data['photo'] = photo;
    data['reference'] = reference;
    data['submit_date'] = submitDate;
    data['submit_time'] = submitTime;
    data['active'] = active;
    data['imagefile'] = imagefile;
    data['meeting_status'] = meetingStatus;
    data['reason'] = reason;
    data['device_details'] = deviceDetails;
    data['submitted_by'] = submittedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['base64'] = base64;
    data['entry_by'] = entryBy;
    data['averageBrightness'] = averageBrightness;
    data['old_user_id'] = oldUserId;
    data['last_update_datetime'] = lastUpdateDatetime;
    data['deleted_at'] = deletedAt;
    data['visit_status'] = visitStatus;
    data['base64_image'] = base64Image;
    return data;
  }
  String get fullImageUrl => ApiConstants1.imagePath;

}
