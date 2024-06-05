import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_cart.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseAddToCart implements IUseCase<CartProduct, String> {
  final IRepositoryCart repositoryCart;

  UseCaseAddToCart({required this.repositoryCart});

  @override
  Future<Either<Failure, String>> execute(CartProduct product) async {
    ApiResponse response = await repositoryCart.saveToCart(product);

    try{
      if (response.statusCode == 200) {
        return const Right("Product is added to cart.");
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseAddToCart(): parsing-error",
        data: e,
      );
    }

    return Left(
      Failure(
        message: "Unable to add this product in cart.",
        statusCode: response.statusCode ?? 400,
      ),
    );
  }
}
