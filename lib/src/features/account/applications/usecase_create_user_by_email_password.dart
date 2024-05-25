import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';

class UseCaseCreateUserByEmailAndPassword implements IUseCase<RequestBodySignup, ApiResponse<UserCredential?>> {
  final IRepositoryAccount repositoryAccount;

  UseCaseCreateUserByEmailAndPassword({required this.repositoryAccount});

  @override
  Future<Either<Failure, ApiResponse<UserCredential?>>> execute(RequestBodySignup request) async {
    ApiResponse<UserCredential?> response = await repositoryAccount.createUserByEmailAndPassword(request);

    if (response.statusCode == 200) {
      return Right(response);
    }

    return Left(
      Failure(
        message: response.message ?? "Something is went wrong!",
        statusCode: response.statusCode ?? 400,
      ),
    );
  }
}
