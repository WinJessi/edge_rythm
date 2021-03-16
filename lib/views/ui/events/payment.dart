import 'package:edge_rythm/views/ui/events/ticket.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const route = '/paymentscreen';
  const PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1))
        .then((value) => Navigator.of(context).pushNamed(TicketScreen.route));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
