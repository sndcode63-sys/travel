class Data1 {
  String? uniqueKey;
  String? authorizationToken;

  Data1({this.uniqueKey, this.authorizationToken});

  Data1.fromJson(Map<String, dynamic> json) {
    uniqueKey = json['uniqueKey'];
    authorizationToken = json['authorization_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uniqueKey'] = uniqueKey;
    data['authorization_token'] = authorizationToken;
    return data;
  }
}
