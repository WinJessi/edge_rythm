import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducersHistory extends StatelessWidget {
  const ProducersHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ProducersProvider>(context, listen: false)
            .fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            return Consumer<ProducersProvider>(
              builder: (context, value, child) => ListView(
                children: [],
              ),
            );
          }
        },
      ),
    );
  }
}
