import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/requstbody/requestbody_checkout.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCasePlaceOrder implements IUseCase<RequestBodyCheckout, String> {
  final IRepositoryMerchandise repositoryMerchandise;

  UseCasePlaceOrder({required this.repositoryMerchandise});

  @override
  Future<Either<Failure, String>> execute(RequestBodyCheckout request) async {
    ApiResponse response = await repositoryMerchandise.placeOrder(request);

    try{
      if (response.statusCode == 200) {
        return Right(response.message??"Successful");
      }
    }catch(e){
      Debugger.debug(
        title: "UseCasePlaceOrder(): parsing-error",
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
