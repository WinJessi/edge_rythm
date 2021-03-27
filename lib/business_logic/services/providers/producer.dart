import 'dart:convert';
import 'dart:io';

import 'package:edge_rythm/business_logic/model/appointment.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var url = 'https://soft-demo.online/edge-api';
var client = http.Client();

class ProducersProvider with ChangeNotifier {
  List<Producers> producers = [];
  List<Appointment> appointments = [];
  var appointment = {
    AptMap.title: '',
    AptMap.session: '',
    AptMap.price: '',
    AptMap.date: '',
    AptMap.time: '12:00 PM',
  };

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  Future fetchProducers() async {
    producers.clear();
    getToken().then((token) async {
      try {
        var response = await http.get(
          Uri.parse('$url/producer/'),
          headers: {HttpHeaders.authorizationHeader: token},
        );
        var data = json.decode(response.body) as List<dynamic>;
        data.forEach((element) {
          producers.add(Producers.fromJson(element));
          producers.shuffle();
        });
        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }

  Future setAppointmentParameters(var key, var value) async {
    appointment.update(key, (_) => value);
    print(appointment);
    notifyListeners();
  }

  Future<void> confirmAppointment(var id) async {
    var data = HtmlCharacterEntities.encode(json.encode(appointment));
    // print(data);
    getToken().then((token) async {
      try {
        await http.post(
          Uri.parse('$url/appointment/add'),
          body: {'producer_id': '$id', 'appoinment_info': data},
          headers: {HttpHeaders.authorizationHeader: token},
        );
        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }

  // List<Map<DateTime, List<Appointment>>> groupedStudents = [];
  Future fetchAppointments() async {
    getToken().then((token) async {
      appointments.clear();
      try {
        var response = await http.get(
          Uri.parse('$url/appointment/'),
          headers: {HttpHeaders.authorizationHeader: token},
        );
        var data = json.decode(response.body) as List<dynamic>;
        data.forEach((element) {
          appointments.add(Appointment.fromJson(element));
        });

        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }
}

class AptMap {
  static const session = 'session';
  static const price = 'price';
  static const date = 'date';
  static const time = 'time';
  static const title = 'title';
}
