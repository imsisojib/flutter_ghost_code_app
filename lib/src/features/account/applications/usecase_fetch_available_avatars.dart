import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseFetchAvailableAvatars implements IUseCase<Empty, List<Avatar>> {
  final IRepositoryAccount repositoryAccount;

  UseCaseFetchAvailableAvatars({required this.repositoryAccount});

  @override
  Future<Either<Failure, List<Avatar>>> execute(_) async {
    ApiResponse response = await repositoryAccount.fetchAvailableAvatars();

    try{
      if (response.statusCode == 200) {
        List<Avatar> avatars = [];
        List<QueryDocumentSnapshot> docs = response.data;
        for (var element in docs) {
          avatars.add(Avatar.fromJson(element.data() as Map<String, dynamic>));
        }

        return Right(avatars);
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseFetchAvailableAvatars(): parsing-error",
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
