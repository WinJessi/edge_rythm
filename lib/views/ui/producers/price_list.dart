import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/producers/schedule.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducersPriceList extends StatelessWidget {
  static const route = '/producerpricelist';
  const ProducersPriceList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var producer = ModalRoute.of(context).settings.arguments as Producers;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              'Booking price list',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Session',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            ),
          ),
          SessionList(prices: producer.prices),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GradientRaisedButton(
              child: Text(
                'Schedule an appointment',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => Navigator.of(context).pushNamed(
                ScheduleAppointment.route,
                arguments: producer,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SessionList extends StatefulWidget {
  const SessionList({
    Key key,
    this.prices,
  }) : super(key: key);

  final List<dynamic> prices;

  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  var _current = 0;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      var p = Provider.of<ProducersProvider>(context, listen: false);
      p.setAppointmentParameters(
        AptMap.session,
        widget.prices.first[AptMap.session],
      );
      p.setAppointmentParameters(
        AptMap.price,
        widget.prices.first[AptMap.price],
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProducersProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        title: Text('Select session'),
        children: [
          for (var i = 0; i < widget.prices.length; i++)
            ListTile(
              onTap: () {
                setState(() {
                  _current = i;
                });
                pro.setAppointmentParameters(
                  AptMap.session,
                  widget.prices[i][AptMap.session],
                );
                pro.setAppointmentParameters(
                  AptMap.price,
                  widget.prices[i][AptMap.price],
                );
              },
              tileColor: _current == i
                  ? Colors.blue.withOpacity(.3)
                  : Colors.transparent,
              title: Text(
                widget.prices[i]['session'],
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
              trailing: Text(
                'N${widget.prices[i]['price']}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            )
        ],
      ),
    );
  }
}
