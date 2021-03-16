import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  static const route = '/ticketscreen';
  const TicketScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top * 1.5),
              Image.asset('assets/images/success.png'),
              SizedBox(height: 15),
              Text(
                'Payment successful',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Text(
                    'Your tickets',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
