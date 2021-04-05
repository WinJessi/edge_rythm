import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:edge_rythm/business_logic/model/chat.dart';
import 'package:edge_rythm/business_logic/model/message.dart';
import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var url = 'https://soft-demo.online/edge-api';
var client = http.Client();

class ChatProvider with ChangeNotifier {
  Timer timer;
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

  Future allMessages(var receiver) async {
    chat.clear();
    getToken().then((value) async {
      try {
        var response = await http.post(
          Uri.parse('$url/messages/get'),
          body: {'receiver': '$receiver'},
          headers: {HttpHeaders.authorizationHeader: value},
        );
        var data = (json.decode(response.body)) as List<dynamic>;
        data.forEach((element) {
          Future.delayed(Duration(milliseconds: 500)).then((value) {
            chat.add(ChatModel.fromJson(element));
            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }

  List<MessageModel> messages = [];
  Future getMessage() async {
    messages.clear();
    getToken().then((value) async {
      try {
        var response = await http.get(
          Uri.parse('$url/messages/'),
          headers: {HttpHeaders.authorizationHeader: value},
        );
        var data = (json.decode(response.body)) as List<dynamic>;
        data.forEach((element) async {
          var sender = await getParticularUser(value, element['sender']);
          var receiver = await getParticularUser(value, element['receiver']);
          Future.delayed(Duration(milliseconds: 500)).then((value) {
            messages.add(MessageModel.fromJson({
              MessageMap.chat: ChatModel.fromJson(element),
              MessageMap.sender: sender,
              MessageMap.receiver: receiver,
            }));
            notifyListeners();
          });
        });
      } catch (error) {
        throw error;
      }
    });
  }

  refreshMessages(var receiver) async {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      print('refresh called $receiver');
      getToken().then((value) async {
        try {
          var response = await http.post(
            Uri.parse('$url/messages/get'),
            body: {'receiver': '$receiver'},
            headers: {HttpHeaders.authorizationHeader: value},
          );
          var data = (json.decode(response.body)) as List<dynamic>;
          chat.clear();
          data.forEach((element) {
            if (!chat.asMap().containsKey(element['id'])) {
              chat.add(ChatModel.fromJson(element));
              notifyListeners();
            }
          });
          notifyListeners();
        } catch (error) {
          throw error;
        }
      });
    });
  }

  cancelTimer() async {
    timer.cancel();
  }

  Future<UserModel> getParticularUser(token, uid) async {
    try {
      var response = await http.get(
        Uri.parse('$url/user/$uid'),
        headers: {HttpHeaders.authorizationHeader: token},
      );
      var data = json.decode(response.body);
      return UserModel.fromJsonLocally(data);
    } catch (error) {
      throw error;
    }
  }

  Future sendMessage() async {
    getToken().then((value) async {
      try {
        var response = await http.post(
          Uri.parse('$url/messages/new'),
          body: message,
          headers: {HttpHeaders.authorizationHeader: value},
        );
        var data = json.decode(response.body);
        chat.add(ChatModel.fromJson(data));
        notifyListeners();
      } catch (error) {
        throw error;
      }
    });
  }
}
