import 'package:flutter_boilerplate_code/src/features/merchandise/domain/abstract_product.dart';

class CartProduct implements IProduct{
  String? id;
  String? type;
  String? name;
  String? thumb;
  double? price;
  double? discountPrice;
  int? quantity;
  String? size;

  CartProduct({
    this.name,
    this.id,
    this.quantity,
    this.thumb,
    this.discountPrice,
    this.price,
    this.size,
    this.type,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    thumb = json['thumb'];
    price = double.tryParse("${json['price']}");
    discountPrice = double.tryParse("${json['discountPrice']}");
    quantity = json["quantity"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['thumb'] = thumb;
    map['price'] = price;
    map['discountPrice'] = discountPrice;
    map['size'] = size;
    map['quantity'] = quantity;
    return map;
  }

  @override
  String toString() {
    return 'CartProduct{id: $id, type: $type, name: $name, thumb: $thumb, price: $price, discountPrice: $discountPrice, size: $size, quantity: $quantity}';
  }
}
