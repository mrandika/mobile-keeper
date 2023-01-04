import 'warehouse_storage.dart';

class ItemLocation {
  String? id;
  String? itemId;
  String? warehouseStorageId;
  int? stock;
  String? createdAt;
  String? updatedAt;
  WarehouseStorage? storage;

  ItemLocation(
      {this.id,
        this.itemId,
        this.warehouseStorageId,
        this.stock,
        this.createdAt,
        this.updatedAt,
        this.storage});

  ItemLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    warehouseStorageId = json['warehouse_storage_id'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storage =
    json['storage'] != null ? WarehouseStorage.fromJson(json['storage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['warehouse_storage_id'] = this.warehouseStorageId;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.storage != null) {
      data['storage'] = this.storage!.toJson();
    }
    return data;
  }
}