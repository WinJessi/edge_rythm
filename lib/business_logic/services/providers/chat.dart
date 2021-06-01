import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edge_rythm/business_logic/model/chat.dart';
import 'package:edge_rythm/business_logic/model/message.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

BaseOptions options = new BaseOptions(
  baseUrl: dotenv.env['BASE_URL'],
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = new Dio(options);

class ChatProvider with ChangeNotifier {
  List<ChatModel> chat = [];
  var message = {
    ChatMap.receiver: 0,
    ChatMap.message: '',
  };

  Future setBody(var key, var value) async {
    message.update(key, (_) => value);
    notifyListeners();
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(UserMap.token);
  }

  Stream<List<ChatModel>> allMessages(var receiver) async* {
    while (true) {
      var token = await getToken();

      try {
        var response = await dio.post(
          '/messages/get',
          data: {'receiver': '$receiver'},
          options: Options(headers: {HttpHeaders.authorizationHeader: token}),
        );

        var data = (response.data) as List<dynamic>;
        data.forEach((element) {
          var ct = ChatModel.fromJson(element);

          if (chat.isEmpty) {
            chat.add(ct);
          } else {
            if ((chat.firstWhere((c) => c.id == ct.id, orElse: () => null)) !=
                null) {
            } else {
              chat.add(ct);
            }
          }
        });

        yield chat;
      } catch (error) {
        throw error;
      }
    }
  }

  List<MessageModel> messages = [];

  Future getMessage(BuildContext context) async {
    messages.clear();
    getToken().then((token) async {
      try {
        var response = await dio.get(
          '/messages/',
          options: Options(headers: {HttpHeaders.authorizationHeader: token}),
        );
        var data = (response.data) as List<dynamic>;
        data.forEach((element) async {
          var sender = await getParticularUser(token, element['sender']);
          var receiver = await getParticularUser(token, element['receiver']);

          Future.delayed(Duration(milliseconds: 500)).then((value) {
            messages.add(
              MessageModel.fromJson({
                MessageMap.chat: ChatModel.fromJson(element),
                MessageMap.sender: sender,
                MessageMap.receiver: receiver,
              }),
            );

            notifyListeners();
          });
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

  Future<UserModel> getParticularUser(token, uid) async {
    try {
      var response = await dio.get(
        '/user/$uid',
        options: Options(headers: {HttpHeaders.authorizationHeader: token}),
      );
      var data = (response.data);
      return UserModel.fromJsonLocally(data);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future sendMessage() async {
    var token = await getToken();
    try {
      var response = await dio.post(
        '/messages/new',
        data: message,
        options: Options(headers: {HttpHeaders.authorizationHeader: token}),
      );
      var data = (response.data);
      chat.add(ChatModel.fromJson(data));
      notifyListeners();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
