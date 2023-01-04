import 'warehouse_aisle.dart';

class WarehouseStorage {
  String? id;
  String? warehouseAisleId;
  String? warehouseAisleColumnId;
  String? warehouseAisleRowId;
  String? createdAt;
  String? updatedAt;
  WarehouseAisle? aisle;

  WarehouseStorage(
      {this.id,
        this.warehouseAisleId,
        this.warehouseAisleColumnId,
        this.warehouseAisleRowId,
        this.createdAt,
        this.updatedAt,
        this.aisle});

  WarehouseStorage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseAisleId = json['warehouse_aisle_id'];
    warehouseAisleColumnId = json['warehouse_aisle_column_id'];
    warehouseAisleRowId = json['warehouse_aisle_row_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    aisle = json['aisle'] != null ? WarehouseAisle.fromJson(json['aisle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['warehouse_aisle_id'] = this.warehouseAisleId;
    data['warehouse_aisle_column_id'] = this.warehouseAisleColumnId;
    data['warehouse_aisle_row_id'] = this.warehouseAisleRowId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.aisle != null) {
      data['aisle'] = this.aisle!.toJson();
    }
    return data;
  }
}