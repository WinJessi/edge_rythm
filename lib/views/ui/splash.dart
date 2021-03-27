import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/ui/welcome.dart';
import 'package:edge_rythm/views/ui/what.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.isAuth});
  final bool isAuth;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      Provider.of<UserProvider>(context, listen: false)
          .autoLogin()
          .then((value) async {
        if (value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              WhatDoYouWantScreen.route, (route) => false);
        } else {
          var pref = await SharedPreferences.getInstance();
          if (pref.containsKey('WELCOME')) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AuthenticationScreen.route, (route) => false);
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(WelcomeScreen.route, (route) => false);
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
