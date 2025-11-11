class PostRelationModel {
  String? actiontype;
  String? reraSerial;
  String? reraNumber;
  String? teamName;
  String? pinName;
  String? locationName;
  int? status;
  String? message;

  PostRelationModel({
    this.actiontype,
    this.reraSerial,
    this.reraNumber,
    this.teamName,
    this.pinName,
    this.locationName,
    this.status,
    this.message,

  });

  PostRelationModel.fromJson(Map<String, dynamic> json) {
    actiontype = json['actiontype'];
    reraSerial = json['rera_serial'];
    reraNumber = json['rera_number'];
    teamName = json['team_name'];
    pinName = json['pin_name'];
    locationName = json['location_name'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actiontype'] = actiontype;
    data['rera_serial'] = reraSerial;
    data['rera_number'] = reraNumber;
    data['team_name'] = teamName;
    data['pin_name'] = pinName;
    data['location_name'] = locationName;
    return data;
  }
}
