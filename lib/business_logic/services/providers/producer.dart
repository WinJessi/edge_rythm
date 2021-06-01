import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge_rythm/business_logic/model/appointment.dart';
import 'package:edge_rythm/business_logic/model/category.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/model/producer_appointment.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

BaseOptions options = new BaseOptions(
  baseUrl: dotenv.env['BASE_URL'],
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

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

  var time = {
    'hour': '01',
    'minute': '00',
    'time': 'AM',
  };

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  realtimeSearch(var search) async {
    prods.retainWhere(
        (element) => element.name.toLowerCase().contains(search.toLowerCase()));
    print(prods.length);
    notifyListeners();
  }

  Future<void> fetchCategories(BuildContext context) async {
    if (_categories.isEmpty) {
      try {
        var response = await dio.get('/admin/category');
        var data = (response.data);

        (data as List<dynamic>).forEach((element) {
          _categories.add(Category.fromJson(element));
        });

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    }
  }

  List<Producers> prods = [];
  Future<List<Producers>> getProducer(var cat) async {
    prods.clear();
    prods = [...producers];
    prods.retainWhere((element) => element.role == cat);
    return prods;
  }

  Future<void> fetchProducers(BuildContext context) async {
    producers.clear();
    getToken().then((token) async {
      try {
        var response = await dio.get(
          '/producer/',
          options: Options(headers: {'Authorization': '$token'}),
        );
        var data = (response.data) as List<dynamic>;

        data.forEach((element) {
          producers.add(Producers.fromJson(element));
        });

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  Future setTime(var key, var value) async {
    time.update(key, (_) => value);
    notifyListeners();
  }

  Future setAppointmentParameters(var key, var value) async {
    appointment.update(key, (_) => value);
    notifyListeners();
  }

  Future<void> confirmAppointment(var id, BuildContext context) async {
    appointment.update(AptMap.time,
        (_) => '${time['hour']}:${time['minute']} ${time['time']}');

    var data = HtmlCharacterEntities.encode(json.encode(appointment));
    getToken().then((token) async {
      try {
        await dio.post(
          '/appointment/add',
          data: {'producer_id': '$id', 'appoinment_info': data},
          options: Options(headers: {'Authorization': '$token'}),
        );
        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  Future fetchAppointments(BuildContext context) async {
    getToken().then((token) async {
      appointments.clear();
      try {
        var response = await dio.get(
          '/appointment/',
          options: Options(headers: {'Authorization': '$token'}),
        );
        var data = (response.data) as List<dynamic>;
        data.forEach((element) {
          appointments.add(Appointment.fromJson(element));
        });

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  List<ProducerAppointment> pappointments = [];
  Future fetchProducerAppointments(BuildContext context) async {
    pappointments.clear();
    getToken().then((token) async {
      appointments.clear();
      try {
        var response = await dio.get(
          '/appointment/producer',
          options: Options(headers: {'Authorization': '$token'}),
        );
        var data = (response.data) as List<dynamic>;
        data.forEach((element) {
          pappointments.add(ProducerAppointment.fromJson(element));
        });

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
    });
  }

  Future appointmentFulfilled(var id, BuildContext context) async {
    getToken().then((token) async {
      try {
        await dio.put(
          '/appointment/$id',
          options: Options(headers: {'Authorization': '$token'}),
        );

        appointments.removeWhere((element) => element.id == id);

        notifyListeners();
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          timeOut(context);
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
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
