import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate_code/src/config/config_firebase.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/game_event.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/request_bodys/requestbody_purchased_tickets.dart';
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

  @override
  Future<ApiResponse> fetchTickets() async {
    ApiResponse apiResponse = ApiResponse();
    String gameEventId = "08082024Tour02";

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(gameEventId).get();
      if (documentSnapshot.exists) {
        GameEvent gameEvent = GameEvent.fromJson(documentSnapshot.data()!);
        //now fetch tickets
        List<Ticket> _tickets = [];
        QuerySnapshot<Map<String, dynamic>> ticketSnapshot =
            await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(gameEventId).collection("tickets").get();
        for (DocumentSnapshot<Map<String, dynamic>> doc in ticketSnapshot.docs) {
          _tickets.add(Ticket.fromJson(doc.data() ?? {}));
        }
        gameEvent.tickets = _tickets;

        apiResponse.data = gameEvent;
        apiResponse.message = "Ticket is generated successfully!";
        apiResponse.statusCode = 200;
      } else {
        apiResponse.message = "No data found!";
        apiResponse.statusCode = 400;
      }
    } catch (e) {
      //if any error
      Debugger.debug(
        title: "RepositoryGameEvents.fetchTickets(): parsing-error",
        data: e,
      );
      apiResponse.message = "Unable to fetch tickets.";
      apiResponse.statusCode = 501;
    }

    Debugger.debug(
      title: "RepositoryGameEvents.fetchTickets(): response",
      data: apiResponse.data,
    );
    Debugger.debug(
      title: "RepositoryGameEvents.fetchTickets(): status-code",
      data: apiResponse.statusCode,
    );

    return apiResponse;
  }

  @override
  Future<ApiResponse<List<PurchasedTickets>>> fetchPurchasedTickets() async{

    String? userId = firebaseInterceptor.getAuth().currentUser?.uid;
    if(userId==null){
      return ApiResponse(
        statusCode: 401,
        message: "Unauthorized! Please login first.",
      );
    }
    ApiResponse<List<PurchasedTickets>> apiResponse = ApiResponse();

    try{
      List<PurchasedTickets> purchasedTickets = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTicketPurchases).where("userId",isEqualTo: userId).get();
      if(querySnapshot.docs.isNotEmpty){
        //means data found
        querySnapshot.docs.forEach((doc) async {
          var purchaseOrder = PurchasedTickets.fromJson(doc.data());
          ///fetching purchased ticket's details
          List<Ticket> tickets = [];
          purchaseOrder.ticketIds?.forEach((ticketId) async {
            DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(purchaseOrder.eventId).collection("tickets").doc(ticketId).get();
            if(documentSnapshot.exists){
              tickets.add(Ticket.fromJson(documentSnapshot.data()!));
            }
          });

          purchaseOrder.tickets = tickets;
          purchasedTickets.add(purchaseOrder);
        });

        apiResponse.data = purchasedTickets;
        apiResponse.message = "Successful";
        apiResponse.statusCode = 200;

      }else{
        apiResponse.data = [];
        apiResponse.message = "No purchase history found!";
        apiResponse.statusCode = 400;
      }
    }catch(e){
      Debugger.debug(
        title: "RepositoryGameEvents.fetchPurchasedTickets(): parsing-error",
        data: e,
      );
    }

    Debugger.debug(
      title: "RepositoryGameEvents.fetchPurchasedTickets(): response",
      data: apiResponse.toString(),
    );

    return apiResponse;
  }

  @override
  Future<ApiResponse> purchaseTickets(RequestBodyPurchasedTickets request) async {
    ApiResponse apiResponse = ApiResponse();
    String purchasedId = firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTicketPurchases).doc().id;

    try {
      await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTicketPurchases).doc(purchasedId).set({
        "id": purchasedId,
        "userId": request.userId,
        "eventId": request.eventId,
        "paymentMethod": request.paymentMethod,
        "transactionId": request.transactionId,
        "total": request.total,
        "tickets": request.ticketIds,
        "address": request.address,
        "phoneNumber": request.phoneNumber,
        "customerName": request.customerName,
      });

      CollectionReference ticketsRef =
          firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableTours).doc(request.eventId).collection("tickets");
      WriteBatch batch = firebaseInterceptor.getFirestore().batch();

      for (var id in request.ticketIds) {
        DocumentReference docRef = ticketsRef.doc(id);
        batch.set(
          docRef,
          {
            "purchasedBy": request.userId,
          },
          SetOptions(
            merge: true,
          ),
        );
      }

      // Commit the batch
      await batch.commit();

      apiResponse.message = "Congratulations! Your tickets has been booked.";
      apiResponse.statusCode = 200;
    } catch (e) {
      //if any error
      apiResponse.message = "Unable to book ticket.";
      apiResponse.statusCode = 501;
    }

    Debugger.debug(
      title: "RepositoryGameEvents.purchaseTickets(): status-code",
      data: apiResponse.statusCode,
    );

    return apiResponse;
  }
}
