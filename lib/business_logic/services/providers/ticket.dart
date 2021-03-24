import 'dart:convert';
import 'dart:io';

import 'package:edge_rythm/business_logic/model/myticket.dart';
import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var url = 'https://soft-demo.online/edge-api/';
var client = http.Client();

class TicketProvider with ChangeNotifier {
  List<Ticket> utickets = [];
  List<Ticket> ptickets = [];
  List<MyTicket> myTickets = [];
  Map<String, dynamic> tickets = {
    TMap.title: '',
    TMap.price: '',
    TMap.howMany: 1,
    TMap.ticket: null,
  };

  get price {
    return tickets;
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  Future<void> upcomingEvents() async {
    utickets.clear();
    try {
      var response = await client.get(Uri.parse('$url/ticket/'));
      var res = json.decode(response.body) as List<dynamic>;
      res.forEach((element) {
        var model = Ticket.fromJson(element);
        utickets.add(model);
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> popularEvents() async {
    ptickets.clear();
    try {
      var response = await client.get(Uri.parse('$url/ticket/popular'));
      var res = json.decode(response.body) as List<dynamic>;
      res.forEach((element) {
        var model = Ticket.fromJson(element);
        ptickets.add(model);
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future setPrice(key, value) async {
    tickets.update(key, (_) => value);
    notifyListeners();
  }

  Future<void> newTicket(id, booking) async {
    myTickets.clear();
    getToken().then((value) async {
      try {
        var response = await client.post(Uri.parse('$url/tickets/add'), body: {
          MyTicketMap.ticket_id: '$id',
          MyTicketMap.ticket_type: tickets[TMap.title],
          MyTicketMap.booking_id: '$booking',
          MyTicketMap.how_many: '${tickets[TMap.howMany]}',
        }, headers: {
          HttpHeaders.authorizationHeader: value
        });

        var data = json.decode(response.body);
        myTickets.add(MyTicket.fromJson(data));
        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }
}

class TMap {
  static const title = 'title';
  static const price = 'price';
  static const howMany = 'how_many';
  static const ticket = 'ticket';
}
