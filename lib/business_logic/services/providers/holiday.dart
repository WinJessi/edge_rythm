import 'dart:convert';

import 'package:edge_rythm/business_logic/model/holiday.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var url = 'https://soft-demo.online/edge-api/';
var client = http.Client();

class HolidayProvider with ChangeNotifier {
  Future<List<Holiday>> checkDate(DateTime dateTime) async {
    List<Holiday> holiday = [];

    var year = dateTime.year;
    var month = dateTime.month;
    var day = dateTime.day;

    try {
      var response = await client.get(
        Uri.parse(
          'https://holidays.abstractapi.com/v1?api_key=0e5c2f7474ed467881c9941c50d08af5&country=NG&year=$year&month=$month&day=$day',
        ),
      );
      var data = json.decode(response.body) as List<dynamic>;
      if (data.isNotEmpty)
        data.forEach((element) {
          holiday.add(Holiday.fromJson(element));
        });
      return holiday;
    } catch (error) {
      throw error;
    }
  }
}
