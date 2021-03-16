import 'package:edge_rythm/views/ui/home.dart';
import 'package:edge_rythm/views/ui/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil(WelcomeScreen.route, (route) => false));
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
