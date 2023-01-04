import 'user_data.dart';
import 'employee.dart';

class User {
  String? id;
  String? email;
  Null? emailVerifiedAt;
  String? userRoleId;
  String? createdAt;
  String? updatedAt;
  UserData? data;
  List<Employee>? employees;

  User(
      {this.id,
        this.email,
        this.emailVerifiedAt,
        this.userRoleId,
        this.createdAt,
        this.updatedAt,
        this.data,
        this.employees});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    userRoleId = json['user_role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    if (json['employees'] != null) {
      employees = <Employee>[];
      json['employees'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['user_role_id'] = this.userRoleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}