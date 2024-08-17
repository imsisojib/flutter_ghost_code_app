import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/order.dart' as entities;
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseFetchMyOrders implements IUseCase<Empty, List<entities.Order>> {
  final IRepositoryMerchandise repositoryMerchandise;

  UseCaseFetchMyOrders({required this.repositoryMerchandise});

  @override
  Future<Either<Failure, List<entities.Order>>> execute(_) async {
    ApiResponse response = await repositoryMerchandise.fetchMyOrders();

    try{
      if (response.statusCode == 200 && response.data!=null) {
        return Right(response.data);
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseFetchMyOrders(): parsing-error",
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
