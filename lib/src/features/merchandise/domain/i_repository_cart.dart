import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';

abstract class IRepositoryCart{
  Future<ApiResponse> fetchCartProducts();
  Future<ApiResponse> saveToCart(CartProduct cartProduct);
  Future<ApiResponse> clearCart();
}