import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';

class GameEvent{
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  double? ticketPrice;
  DateTime? eventDateTime;
  String? status;
  List<Ticket>? tickets;  //local usage or manual process

  GameEvent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ticketPrice = json['ticketPrice'];
    eventDateTime = (json['eventDateTime'] as Timestamp?)?.toDate();
    status = json['status'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['ticketPrice'] = ticketPrice;
    map['eventDateTime'] = eventDateTime;
    map['status'] = status;
    return map;
  }

  @override
  String toString() {
    return 'GameEvent{id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, ticketPrice: $ticketPrice, eventDateTime: $eventDateTime, status: $status}, tickets: ${tickets?.length}';
  }
}