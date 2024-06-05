import 'package:flutter_boilerplate_code/src/features/merchandise/domain/abstract_product.dart';

class Product implements IProduct{
  String? id;
  String? type;
  String? name;
  String? thumb;
  double? price;
  double? discountPrice;
  int? stock;
  List<Variant>? variants;
  List<String>? images;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    name = json['name'];
    thumb = json['thumb'];
    price = double.tryParse("${json['price']}");
    discountPrice = double.tryParse("${json['discountPrice']}");
    stock = json['stock'];
    if(json['variants']!=null){
      variants = <Variant>[];
      json['variants'].forEach((e){
        variants?.add(Variant.fromJson(e));
      });
    }
    try{
      if(json['images']!=null){
        images = json['images'].cast<List<String>>();
      }
    }catch(e){
      //images-casting error
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['thumb'] = thumb;
    map['price'] = price;
    map['discountPrice'] = discountPrice;
    map['stock'] = stock;
    if(variants!=null){
      map['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    map['images'] = images;
    return map;
  }

  @override
  String toString() {
    return 'Product{id: $id, type: $type, name: $name, thumb: $thumb, price: $price, discountPrice: $discountPrice, stock: $stock, variants: $variants}';
  }
}

class Variant{
  String? size;
  int? stock;

  Variant.fromJson(Map<String, dynamic> json){
    size = json['size'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['size'] = size;
    map['stock'] = stock;
    return map;
  }

  @override
  String toString() {
    return 'Variant{size: $size, stock: $stock}';
  }
}