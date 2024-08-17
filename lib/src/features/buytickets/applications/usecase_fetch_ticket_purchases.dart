import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/failure.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_use_case.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/game_event.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class UseCaseTicketPurchases implements IUseCase<Empty, List<PurchasedTickets>> {
  final IRepositoryGameEvents repositoryGameEvents;

  UseCaseTicketPurchases({required this.repositoryGameEvents});

  @override
  Future<Either<Failure, List<PurchasedTickets>>> execute(_) async {
    ApiResponse response = await repositoryGameEvents.fetchPurchasedTickets();

    try{
      if (response.statusCode == 200 && response.data!=null) {
        return Right(response.data);
      }
    }catch(e){
      Debugger.debug(
        title: "UseCaseTicketPurchases(): parsing-error",
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
