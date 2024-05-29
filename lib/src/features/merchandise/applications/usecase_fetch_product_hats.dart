import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseFetchProductsHat implements IUseCase<Empty, List<Product>> {
  final IRepositoryMerchandise repositoryMerchandise;

  UseCaseFetchProductsHat({required this.repositoryMerchandise});

  @override
  Future<Either<Failure, List<Product>>> execute(_) async {
    ApiResponse response = await repositoryMerchandise.fetchProductsByType("hat");

    try{
      if (response.statusCode == 200) {
        List<Product> products = [];
        List<QueryDocumentSnapshot> docs = response.data;
        for (var element in docs) {
          products.add(Product.fromJson(element.data() as Map<String, dynamic>));
        }

        return Right(products);
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseFetchTShirtsProducts(): parsing-error",
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
