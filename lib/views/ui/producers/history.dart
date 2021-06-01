import 'package:edge_rythm/business_logic/model/appointment.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProducersHistory extends StatelessWidget {
  const ProducersHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ProducersProvider>(context, listen: false)
            .fetchAppointments(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            return Consumer<ProducersProvider>(
              builder: (context, value, child) => ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'My Schedule',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  for (var i = 0; i < value.appointments.length; i++)
                    HistoryCard(appointment: value.appointments[i])
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key key,
    this.appointment,
    // this.time,
  }) : super(key: key);

  // final DateTime time;
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(appointment.info['date']);
    return GestureDetector(
      onTap: () => appointmentInfo(context, appointment),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //   child: Text(
          //     '$time',
          //     style: Theme.of(context).textTheme.headline2,
          //   ),
          // ),
          // for (var i = 0; i < appointment.length; i++)
          Container(
            // height: 80,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: date.isBefore(DateTime.now())
                  ? Colors.red.withOpacity(.3)
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage(appointment.producer.photo),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        appointment.producer.name,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 5),
                      Text(
                        appointment.info['session'],
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future appointmentInfo(BuildContext context, Appointment appointment) {
    return showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      appointment.info['session'],
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      'Session',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      DateFormat.yMMMEd()
                          .format(DateTime.parse(appointment.info['date'])),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      'Date',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'N${appointment.info['price']}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      'Price',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
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
}
