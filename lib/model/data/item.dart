import 'item_location.dart';

class Item {
  String? id;
  String? name;
  String? sku;
  int? price;
  String? createdAt;
  String? updatedAt;
  List<ItemLocation>? locations;

  Item(
      {this.id,
        this.name,
        this.sku,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.locations});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['locations'] != null) {
      locations = <ItemLocation>[];
      json['locations'].forEach((v) {
        locations!.add(ItemLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}