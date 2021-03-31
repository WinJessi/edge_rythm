import 'dart:io';

import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/constants.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';

class ProducerPayment extends StatefulWidget {
  static const route = '/producerspaymetn';
  ProducerPayment({Key key}) : super(key: key);

  @override
  _ProducerPaymentState createState() => _ProducerPaymentState();
}

class _ProducerPaymentState extends State<ProducerPayment> {
  PaystackPlugin plugin = new PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: Constants.API_KEY);
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      var pro = Provider.of<ProducersProvider>(context, listen: false);
      var producer = ModalRoute.of(context).settings.arguments as Producers;
      var user = Provider.of<UserProvider>(context, listen: false);

      startPayment(user, pro, producer)
          .then((value) => Navigator.of(context).pop(value));
    });

    super.initState();
  }

  Future<bool> startPayment(
    UserProvider user,
    ProducersProvider producers,
    Producers producer,
  ) async {
    Charge charge = Charge()
      ..amount = int.parse(producers.appointment[AptMap.price]) * 100
      ..reference = _getReference()
      ..email = user.userM.email;

    CheckoutResponse response = await plugin.checkout(
      context,
      logo: Image.asset('assets/images/splash_logo.png'),
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if (response.verify) {
      confirm(context, producer);
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
    return Scaffold();
  }

  Future appointmentSuccess(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(15),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.route, (route) => false);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/images/success.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Booking Succesful',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Your appointment booking successfuly complete. Jaytunes will message you soon',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  confirm(BuildContext context, Producers producer) async {
    try {
      await Provider.of<ProducersProvider>(context, listen: false)
          .confirmAppointment(producer.producerID);
      together();
    } catch (error) {
      throw error;
    }
  }

  void together() async {
    appointmentSuccess(context);
  }
}
