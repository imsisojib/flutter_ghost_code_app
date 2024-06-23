import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_cart.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseClearCart implements IUseCase<Empty, String> {
  final IRepositoryCart repositoryCart;

  UseCaseClearCart({required this.repositoryCart});

  @override
  Future<Either<Failure, String>> execute(_) async {
    ApiResponse response = await repositoryCart.clearCart();

    try{
      if (response.statusCode == 200) {
        return Right(response.message??"Success");
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseClearCart(): parsing-error",
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
