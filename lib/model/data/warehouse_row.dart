class WarehouseRow {
  String? id;
  String? warehouseAisleColumnId;
  String? code;
  String? createdAt;
  String? updatedAt;

  WarehouseRow(
      {this.id,
        this.warehouseAisleColumnId,
        this.code,
        this.createdAt,
        this.updatedAt});

  WarehouseRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseAisleColumnId = json['warehouse_aisle_column_id'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_aisle_column_id'] = this.warehouseAisleColumnId;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}