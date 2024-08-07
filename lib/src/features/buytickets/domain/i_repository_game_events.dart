import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';

abstract class IRepositoryGameEvents{
  Future<ApiResponse> generateTickets();
  Future<ApiResponse> fetchTickets();
}