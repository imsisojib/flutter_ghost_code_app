import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';

class PurchasedTickets{
  String? id; //purchase id
  String? customerName;
  String? phoneNumber;
  String? address;
  double? total;
  String? paymentMethod;
  String? transactionId;
  String? userId;
  String? eventId;
  List<String>? ticketIds;
  List<Ticket>? tickets; //local usages only

  PurchasedTickets({
    this.id,
    required this.userId,
    required this.eventId,
    required this.total,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.ticketIds,
    this.paymentMethod,
    this.transactionId,
    this.tickets,
  });

  PurchasedTickets.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    eventId = json['eventId'];
    address = json['address'];
    customerName = json['customerName'];
    phoneNumber = json['phoneNumber'];
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
    total = json['total'];
    ticketIds = json['tickets']?.cast<String>();
  }

}