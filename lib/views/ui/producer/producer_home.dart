import 'package:edge_rythm/business_logic/model/producer_appointment.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/producer/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProducerHomeScreen extends StatelessWidget {
  const ProducerHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'Upcoming Sessions',
                style: Theme.of(context).textTheme.headline4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(219, 165, 20, 1),
                    Color.fromRGBO(183, 134, 40, 1),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          Consumer<UserProvider>(
            builder: (context, value, child) => GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ProducerProfile.route),
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    value.producer.photo,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ProducersProvider>(context, listen: false)
            .fetchProducerAppointments(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ProducersProvider>(
              builder: (context, value, child) => value.pappointments.length < 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'You don’t have any appointment\nnow check back later',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Text(
                                'My Schedules',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Spacer(),
                              Text(
                                'swipe if done',
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                        for (var i = 0; i < value.pappointments.length; i++)
                          HistoryCard(
                            producerAppointment: value.pappointments[i],
                          ),
                      ],
                    ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key key,
    this.producerAppointment,
  }) : super(key: key);

  final ProducerAppointment producerAppointment;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(producerAppointment.id),
      direction: DismissDirection.endToStart,
      behavior: HitTestBehavior.translucent,
      onDismissed: (direction) {
        Provider.of<ProducersProvider>(context, listen: false)
            .appointmentFulfilled(producerAppointment.id, context);
      },
      background: Container(
        decoration: BoxDecoration(color: Colors.green),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Done',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            ),
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 15)
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => appointmentInfo(context, producerAppointment),
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
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color:
                    // date.isBefore(DateTime.now())
                    //     ? Colors.red.withOpacity(.3)
                    //     :
                    Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: .5,
                      ),
                    ),
                    child: Image.asset('assets/images/rhythm.png'),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          producerAppointment.userModel.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 5),
                        Text(
                          producerAppointment.userModel.email,
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
      ),
    );
  }

  Future appointmentInfo(
      BuildContext context, ProducerAppointment appointment) {
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
                      appointment.info['title'],
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    subtitle: Text(
                      'Title',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black),
                    ),
                  ),
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
