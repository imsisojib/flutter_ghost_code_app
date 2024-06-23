import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/requstbody/requestbody_checkout.dart';

abstract class IRepositoryMerchandise{
  Future<ApiResponse> fetchProductsByType(String type);
  Future<ApiResponse> placeOrder(RequestBodyCheckout request);
}