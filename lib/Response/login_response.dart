class LogInResponseModel {
  String? code;
  String? message;
  LoginResponse? data;

  LogInResponseModel({this.code, this.message, this.data});

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data =
        json['data'] != null ? LoginResponse.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginResponse {
  String? username;
  String? customerId;
  String? type;
  String? accessToken;

  LoginResponse({this.username, this.customerId, this.type, this.accessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    customerId = json['customerId'];
    type = json['type'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['customerId'] = customerId;
    data['type'] = type;
    data['accessToken'] = accessToken;
    return data;
  }
}
