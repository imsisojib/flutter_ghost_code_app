import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_cart.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseFetchCartProducts implements IUseCase<Empty, List<CartProduct>> {
  final IRepositoryCart repositoryCart;

  UseCaseFetchCartProducts({required this.repositoryCart});

  @override
  Future<Either<Failure, List<CartProduct>>> execute(_) async {
    ApiResponse response = await repositoryCart.fetchCartProducts();

    try{
      if (response.statusCode == 200) {
        List<CartProduct> products = [];
        for (var element in response.data) {
          products.add(CartProduct.fromJson(jsonDecode(element)));
        }

        return Right(products);
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseFetchCartProducts(): parsing-error",
        data: e,
      );
    }

    return Left(
      Failure(
        message: response.message ?? "Something is went wrong!",
        statusCode: response.statusCode ?? 400,
      ),
    );
  }
}
