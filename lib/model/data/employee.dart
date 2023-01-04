import 'warehouse.dart';

class Employee {
  String? id;
  String? userId;
  String? warehouseId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Warehouse? warehouse;

  Employee(
      {this.id,
        this.userId,
        this.warehouseId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.warehouse});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    warehouseId = json['warehouse_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['warehouse_id'] = this.warehouseId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    return data;
  }
}