import 'dart:io';

import 'package:edge_rythm/business_logic/services/constants.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  static const route = '/paymentscreen';
  const PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaystackPlugin plugin = new PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: Constants.API_KEY);
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      var user = Provider.of<UserProvider>(context, listen: false);
      var ticket = Provider.of<TicketProvider>(context, listen: false);
      startPayment(user, ticket)
          .then((value) => Navigator.of(context).pop(value));
    });

    super.initState();
  }

  Future<bool> startPayment(UserProvider user, TicketProvider ticket) async {
    Map<String, dynamic> cost = ticket.price;
    int c = int.parse(cost[TMap.price]) * cost[TMap.howMany];

    Charge charge = Charge()
      ..amount = c * 100
      ..reference = _getReference()
      ..email = user.userM.email;

    CheckoutResponse response = await plugin.checkout(
      context,
      logo: Image.asset('assets/images/splash_logo.png'),
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if (response.verify) {
      return true;
    }
    return false;
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    // startPayment();
    return Scaffold();
  }
}
