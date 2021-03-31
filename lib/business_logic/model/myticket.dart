import 'package:edge_rythm/business_logic/model/ticket.dart';

class MyTicket {
  final String id;
  final Ticket ticket;
  final String ticketType;
  final String bookingID;
  final String howMany;

  MyTicket({
    this.id,
    this.bookingID,
    this.howMany,
    this.ticket,
    this.ticketType,
  });

  MyTicket.fromJson(Map<String, dynamic> map)
      : id = map[MyTicketMap.id].toString(),
        bookingID = '${map[MyTicketMap.booking_id]}',
        howMany = map[MyTicketMap.how_many].toString(),
        ticket = Ticket.fromJson({
          TicketMap.show_title: map[TicketMap.show_title],
          TicketMap.show_time: map[TicketMap.show_time],
          TicketMap.show_date: map[TicketMap.show_date],
          TicketMap.show_address: map[TicketMap.show_address],
          TicketMap.show_detail: map[TicketMap.show_detail],
          TicketMap.show_banner: map[TicketMap.show_banner],
          TicketMap.price_list: [],
        }),
        ticketType = map[MyTicketMap.ticket_type].toString();

  Map<String, dynamic> toJson() => {
        MyTicketMap.id: id,
        MyTicketMap.booking_id: bookingID,
        MyTicketMap.how_many: howMany,
        MyTicketMap.ticket_id: ticket.toJson(),
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
