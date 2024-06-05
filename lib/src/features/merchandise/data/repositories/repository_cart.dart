import 'dart:convert';

import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_cart.dart';

class RepositoryCart implements IRepositoryCart {
  final IRepositoryCache repositoryCache;

  RepositoryCart({
    required this.repositoryCache,
  });

  @override
  Future<ApiResponse> fetchCartProducts() async{
    return ApiResponse(
      statusCode: 200,
      data: repositoryCache.fetchCartProducts(),
    );
  }

  @override
  Future<ApiResponse> saveToCart(CartProduct cartProduct) async{
    repositoryCache.saveCartProduct(jsonEncode(cartProduct.toJson()));

    return ApiResponse(
      statusCode: 200,
    );
  }
}
