import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';

class Order {
  String? orderId;
  String? customerName;
  String? phoneNumber;
  String? address;
  double? total;
  List<CartProduct>? products;

  Order({
    this.orderId,
    this.customerName,
    this.phoneNumber,
    this.address,
    this.total,
    this.products,
  });

  Order.fromJson(Map<String, dynamic> json){
    orderId = json['orderId'];
    customerName = json['customerName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    total = json['total'];
    if(json['products']!=null){
      products = <CartProduct>[];
      json['products'].forEach((e){
        products?.add(CartProduct.fromJson(e));
      });
    }
  }

}
