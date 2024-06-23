import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';

class RequestBodyCheckout {
  String customerName;
  String phoneNumber;
  String address;
  double total;
  List<CartProduct> products;

  RequestBodyCheckout({
    required this.total,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.products,
  });
}
