class MyTicket {
  final String id;
  final String ticketID;
  final String ticketType;
  final String bookingID;
  final String howMany;

  MyTicket({
    this.id,
    this.bookingID,
    this.howMany,
    this.ticketID,
    this.ticketType,
  });

  MyTicket.fromJson(Map<String, dynamic> map)
      : id = map[MyTicketMap.id].toString(),
        bookingID = '${map[MyTicketMap.booking_id]}',
        howMany = map[MyTicketMap.how_many].toString(),
        ticketID = map[MyTicketMap.ticket_id].toString(),
        ticketType = map[MyTicketMap.ticket_type].toString();

  Map<String, dynamic> toJson() => {
        MyTicketMap.id: id,
        MyTicketMap.booking_id: bookingID,
        MyTicketMap.how_many: howMany,
        MyTicketMap.ticket_id: ticketID,
        MyTicketMap.ticket_type: ticketType,
      };
}

class MyTicketMap {
  static const id = 'id';
  static const ticket_id = 'ticket_id';
  static const ticket_type = 'ticket_type';
  static const booking_id = 'booking_id';
  static const how_many = 'how_many';
}
