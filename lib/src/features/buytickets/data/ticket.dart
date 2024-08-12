class Ticket {
  String? id;
  String? eventId;
  String? slot;
  String? serial;
  String? purchasedBy;
  bool selected = false;  //only for local usages

  Ticket({
    this.id,
    this.eventId,
    this.slot,
    this.serial,
    this.purchasedBy,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    serial = json['serial'];
    slot = json['slot'];
    purchasedBy = json['purchasedBy'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['eventId'] = eventId;
    map['serial'] = serial;
    map['slot'] = slot;
    map['purchasedBy'] = purchasedBy;
    return map;
  }

  @override
  String toString() {
    return 'Ticket{id: $id, eventId: $eventId, slot: $slot, serial: $serial, purchasedBy: $purchasedBy}';
  }
}
