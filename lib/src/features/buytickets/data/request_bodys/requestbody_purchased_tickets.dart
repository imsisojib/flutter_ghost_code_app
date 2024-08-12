import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';

class RequestBodyPurchasedTickets {
  String customerName;
  String phoneNumber;
  String address;
  double total;
  List<String> ticketIds;
  String? paymentMethod;
  String? transactionId;
  String userId;
  String eventId;

  RequestBodyPurchasedTickets({
    required this.userId,
    required this.eventId,
    required this.total,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.ticketIds,
    this.paymentMethod,
    this.transactionId,
  });
}
