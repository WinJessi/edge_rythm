import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/producer.dart';

BaseOptions options = new BaseOptions(
  baseUrl: dotenv.env['BASE_URL'],
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class UserProvider with ChangeNotifier {
  SharedPreferences prefs;
  var user = {
    UserMap.name: '',
    UserMap.email: '',
    UserMap.phone: '',
    UserMap.pwd: '',
  };

  UserModel userModel;

  saveData(key, value) {
    user.update(key, (_) => value);
  }

  UserModel get userM {
    return userModel;
  }

  Future<UserModel> login(BuildContext context) async {
    try {
      var response = await dio.post(
        '/auth/login',
        data: {
          UserMap.email: user[UserMap.email],
          UserMap.pwd: user[UserMap.pwd],
        },
      );

      var data = response.data as Map<String, dynamic>;
      var model = UserModel.fromJson(data);
      var m = json.encode(model.toJson());

      userModel = model;

      saveToken(data[UserMap.token]);
      saveDetails(m);

      if (model.role != 'USER')
        getProducerProfile(data[UserMap.token], context);

      return userModel;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        timeOut(context);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      throw exception;
    }
  }

  Future<UserModel> register(BuildContext context) async {
    try {
      var response = await dio.post(
        '/auth/register',
        data: user,
      );

      var data = response.data as Map<String, dynamic>;
      var model = UserModel.fromJson(data);
      var m = json.encode(model.toJson());

      userModel = model;

      saveToken(data[UserMap.token]);
      saveDetails(m);
      return userModel;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        timeOut(context);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      throw exception;
    }
  }

  Future<void> saveToken(var token) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(UserMap.token, token);
  }

  Future saveDetails(var user) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(UserMap.user, user);
  }

  Future<UserModel> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(UserMap.token)) return null;

    var data = prefs.getString(UserMap.user);
    userModel = UserModel.fromJsonLocally(json.decode(data));

    if (userModel.role != 'USER') readProducer();

    notifyListeners();
    return userModel;
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  Future<void> logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(UserMap.token);
    pref.remove(UserMap.user);
  }

  Future updateUser() async {
    getToken().then((token) async {
      var response = await dio.put(
        '/user/update',
        data: json.encode({
          UserMap.name: user[UserMap.name],
          UserMap.phone: user[UserMap.phone],
        }),
        options: Options(headers: {'Authorization': '$token'}),
      );

      Map<String, dynamic> data = response.data;
      var model = UserModel.fromJsonLocally(data);

      saveDetails(json.encode(model.toJson()));
      userModel = model;

      notifyListeners();
    });
  }

  Producers producer;
  Future getProducerProfile(var token, BuildContext context) async {
    try {
      var response = await dio.get(
        '/producer/id',
        options: Options(headers: {'Authorization': '$token'}),
      );

      var data = response.data;
      producer = Producers.fromJson(data);

      saveProducer(producer);
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

  Future saveProducer(Producers producers) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(UserMap.producer, json.encode(producers.toJson()));
  }

  Future readProducer() async {
    var pref = await SharedPreferences.getInstance();
    var data = json.decode(pref.getString(UserMap.producer));
    producer = Producers.fromJson(data);
  }

  var prod = {
    ProducersMap.name: '',
    ProducersMap.phone: '',
    ProducersMap.location: '',
    ProducersMap.genre: '',
    ProducersMap.about: '',
    ProducersMap.photo: '',
  };

  void setProd(var key, var value) {
    prod.update(key, (_) => value);
  }

  Future updateProducer(BuildContext context) async {
    File file = new File(prod[ProducersMap.photo]);
    var filename = basename(file.path);

    var form = FormData.fromMap({
      ProducersMap.name: prod[ProducersMap.name],
      ProducersMap.phone: prod[ProducersMap.phone],
      ProducersMap.location: prod[ProducersMap.location],
      ProducersMap.genre: prod[ProducersMap.genre],
      ProducersMap.about: prod[ProducersMap.about],
      ProducersMap.photo:
          await MultipartFile.fromFile(file.path, filename: filename),
    });

    try {
      var token = await getToken();
      await dio.post(
        '/producer/up',
        data: form,
        options: Options(
          headers: {'Authorization': '$token'},
          contentType: Headers.jsonContentType,
        ),
      );
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
