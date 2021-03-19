import 'dart:convert';

import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var url = 'https://soft-demo.online/edge-api/';
var client = http.Client();

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

  get userM {
    return userModel;
  }

  Future<void> login() async {
    try {
      var response = await client.post(
        Uri.parse('$url/auth/login'),
        body: {
          UserMap.email: user[UserMap.email],
          UserMap.pwd: user[UserMap.pwd],
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var model = UserModel.fromJson(data);
      var m = json.encode(model.toJson());

      userModel = model;

      saveToken(data[UserMap.token]);
      saveDetails(m);
    } catch (error) {
      throw error;
    }
  }

  Future<void> register() async {
    try {
      var response = await client.post(
        Uri.parse('$url/auth/register'),
        body: user,
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var model = UserModel.fromJson(data);
      var m = json.encode(model.toJson());

      userModel = model;

      saveToken(data[UserMap.token]);
      saveDetails(m);
    } catch (error) {
      throw error;
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

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(UserMap.token).isEmpty) return false;

    var data = prefs.getString(UserMap.user);
    userModel = UserModel.fromJsonLocally(json.decode(data));

    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return json.decode(pref.getString(UserMap.token));
  }

  Future<void> logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(UserMap.token);
    pref.remove(UserMap.user);
  }
}
