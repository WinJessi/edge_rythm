import 'dart:convert';

class Ticket {
  final int id;
  final String showTitle;
  final String showTime;
  final String showDate;
  final String showAddress;
  final String showDetail;
  final String showBanner;
  final List<dynamic> priceList;

  Ticket({
    this.id,
    this.showAddress,
    this.priceList,
    this.showDate,
    this.showDetail,
    this.showTime,
    this.showTitle,
    this.showBanner,
  });

  Ticket.fromJson(Map<String, dynamic> map)
      : id = map[TicketMap.id],
        showAddress = map[TicketMap.show_address],
        showBanner = map[TicketMap.show_banner],
        showDate = map[TicketMap.show_date],
        showDetail = map[TicketMap.show_detail],
        showTime = map[TicketMap.show_time],
        priceList = [
          {'title': 'Regular', 'price': '1500'},
          {'title': 'VIP', 'price': '15000'},
          {'title': 'VVIP', 'price': '150000'},
        ],
        // priceList = json.decode(map[TicketMap.price_list]),
        showTitle = map[TicketMap.show_title];

  Map<String, dynamic> toJson() => {};
}

class TicketMap {
  static const id = 'id';
  static const show_title = 'show_title';
  static const show_time = 'show_time';
  static const show_date = 'show_date';
  static const show_address = 'show_address';
  static const show_banner = 'show_banner';
  static const price_list = 'price_list';
  static const show_detail = 'show_detail';
}
