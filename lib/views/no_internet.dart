import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/producer/home.dart';
import 'package:edge_rythm/views/ui/what.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoInternet extends StatelessWidget {
  static const route = '/nointernet';
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/wifi.png'),
              SizedBox(height: 15),
              Text(
                'Seem there\'s no\ninternet connection',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Please check your internet connection\nand try again',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Text('Try again'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
