import 'package:flutter/material.dart';

class EventsNotification extends StatelessWidget {
  const EventsNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/chat.png',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 30),
          Text(
            'You don’t have any messages\nnow check back later',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
