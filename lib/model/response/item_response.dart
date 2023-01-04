import '../data/item.dart';

class ItemResponse {
  int? code;
  String? message;
  Null? error;
  List<Item>? data;

  ItemResponse({this.code, this.message, this.error, this.data});

  ItemResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Item>[];
      json['data'].forEach((v) {
        data!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}