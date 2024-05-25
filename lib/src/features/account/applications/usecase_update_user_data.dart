import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';

class UseCaseUpdateUserData implements IUseCase<UserModel, String> {
  final IRepositoryAccount repositoryAccount;

  UseCaseUpdateUserData({required this.repositoryAccount});

  @override
  Future<Either<Failure, String>> execute(UserModel request) async {
    var response = await repositoryAccount.updateUserInfo(request);

    if (response.statusCode == 200) {
      return Right(response.message??"Success");
    }

    return Left(
      Failure(
        message: response.message ?? "Something is went wrong!",
        statusCode: response.statusCode ?? 400,
      ),
    );
  }
}
