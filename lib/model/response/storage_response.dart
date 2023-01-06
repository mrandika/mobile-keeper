import 'package:keeper/model/data/warehouse_storage.dart';

class StorageResponse {
  int? code;
  String? message;
  Null? error;
  List<WarehouseStorage>? data;

  StorageResponse({this.code, this.message, this.error, this.data});

  StorageResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <WarehouseStorage>[];
      json['data'].forEach((v) {
        data!.add(WarehouseStorage.fromJson(v));
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