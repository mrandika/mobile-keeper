import 'package:keeper/model/data/user.dart';

class ProfileResponse {
  int? code;
  String? message;
  Null? error;
  User? data;

  ProfileResponse({this.code, this.message, this.error, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}