import 'warehouse.dart';

class WarehouseAisle {
  String? id;
  String? warehouseId;
  String? code;
  String? createdAt;
  String? updatedAt;
  Warehouse? warehouse;

  WarehouseAisle(
      {this.id,
        this.warehouseId,
        this.code,
        this.createdAt,
        this.updatedAt,
        this.warehouse});

  WarehouseAisle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseId = json['warehouse_id'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    warehouse = json['warehouse'] != null
        ? Warehouse.fromJson(json['warehouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['warehouse_id'] = this.warehouseId;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.toJson();
    }
    return data;
  }
}