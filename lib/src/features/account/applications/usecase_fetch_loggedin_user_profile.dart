import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseFetchLoggedInUserProfile implements IUseCase<Empty, UserModel> {
  final IRepositoryAccount repositoryAccount;

  UseCaseFetchLoggedInUserProfile({required this.repositoryAccount});

  @override
  Future<Either<Failure, UserModel>> execute(_) async {
    ApiResponse response = await repositoryAccount.fetchLoggedInUserProfile();

    try{
      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(response.data));
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseFetchLoggedInUserProfile(): parsing-error",
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
