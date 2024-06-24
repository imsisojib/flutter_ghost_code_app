import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boilerplate_code/src/config/config_firebase.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class RepositoryGameEvents implements IRepositoryGameEvents {
  final IFirebaseInterceptor firebaseInterceptor;

  RepositoryGameEvents({
    required this.firebaseInterceptor,
  });

  @override
  Future<ApiResponse> generateTickets() async {
    ApiResponse apiResponse = ApiResponse();
    String gameEventId = "08082024Tour02";

    try {
      await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(gameEventId).set({
        "id": gameEventId,
        "name": "Ghost-1 Finding Tour",
        "address": "Dhaka, Bangladesh",
        "location": const GeoPoint(23.750916, 90.441555),
        "ticketPrice": 10.0,
        "eventDateTime": DateTime(2024, 7, 7),
        "status": "active",
      });

      CollectionReference ticketsRef =
          firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(gameEventId).collection("tickets");
      WriteBatch batch = firebaseInterceptor.getFirestore().batch();

      List<String> slots = ["8PM", "10PM", "8AM", "10AM"];
      List<Ticket> tickets = [];
      for (var element in slots) {
        for (int i = 0; i < 30; i++) {
          tickets.add(
            Ticket(
              id: ticketsRef.doc().id,
              eventId: gameEventId,
              slot: element,
              serial: "${i * 2}".padLeft(2, "0"),
            ),
          );
        }
      }

      for (var element in tickets) {
        DocumentReference docRef = ticketsRef.doc(element.id);
        batch.set(docRef, element.toJson());
      }

      // Commit the batch
      await batch.commit();

      apiResponse.message = "Ticket is generated successfully!";
      apiResponse.statusCode = 200;
    } catch (e) {
      //if any error
      apiResponse.message = "Unable to place order.";
      apiResponse.statusCode = 501;
    }

    Debugger.debug(
      title: "RepositoryGameEvents.generateTickets(): status-code",
      data: apiResponse.statusCode,
    );

    return apiResponse;
  }
}
