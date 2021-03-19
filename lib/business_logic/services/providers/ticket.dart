import 'dart:convert';

import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var url = 'https://soft-demo.online/edge-api/';
var client = http.Client();

class TicketProvider with ChangeNotifier {
  List<Ticket> utickets = [];
  List<Ticket> ptickets = [];
  Map<String, dynamic> tickets = {};

  Future<void> upcomingEvents() async {
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
    try {
      var response = await client.get(Uri.parse('$url/ticket/'));
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
}

class TMap {
  static const title = 'title';
  static const price = 'price';
  static const howMany = 'how_many';
}
