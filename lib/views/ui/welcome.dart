import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = '/welcomescreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  checked() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('WELCOME', true);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AuthenticationScreen.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top,
            ),
            child: Image.asset(
              'assets/images/welcome.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Booking for a studio session just got easier.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 15),
                Text(
                  'Dont have a producer?\nNo problem, search through our collection\nfor talented producers and sound engineers',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                GradientRaisedButton(
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => checked(),
                ),
                SizedBox(height: 15)
              ],
            ),
          )
        ],
      ),
    );
  }
}
