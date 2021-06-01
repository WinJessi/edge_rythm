import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/producers/payment.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleAppointment extends StatefulWidget {
  static const route = '/scheduleappointment';
  const ScheduleAppointment({Key key}) : super(key: key);

  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProducersProvider>(context, listen: false);
    var producer = ModalRoute.of(context).settings.arguments as Producers;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  'Schedule an appointment',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  'Select date',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(hours: 4380)),
                  focusedDay: DateTime.now(),
                  onCalendarCreated: (_) => Future.delayed(Duration.zero).then(
                    (value) => pro.setAppointmentParameters(
                      AptMap.date,
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                  onDaySelected: (day, events) async {
                    if (day.isBefore(DateTime.now())) {
                      AchievementView(
                        context,
                        title: "Invalid date",
                        subTitle: "You can\'t choose a day before current date",
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        typeAnimationContent: AnimationTypeAchievement.fade,
                        borderRadius: 20.0,
                        color: Colors.black,
                        alignment: Alignment.topCenter,
                        duration: Duration(seconds: 3),
                      )..show();
                    } else {
                      if (day.weekday == 7) {
                        AchievementView(
                          context,
                          title: "Weekend",
                          subTitle:
                              "You can\'t book an appointment by weekends",
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          typeAnimationContent: AnimationTypeAchievement.fade,
                          borderRadius: 20.0,
                          color: Colors.black,
                          alignment: Alignment.topCenter,
                          duration: Duration(seconds: 3),
                        )..show();
                      } else {
                        pro.setAppointmentParameters(
                          AptMap.date,
                          day.toIso8601String(),
                        );
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  'Select time',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Row(
                  children: [
                    TimePicker(),
                    SizedBox(width: 15),
                    TimeSelect(),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GradientRaisedButton(
                  child: Text(
                    'Confirm Appointment',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    if (pro.appointment[AptMap.date].isEmpty) {
                      AchievementView(
                        context,
                        title: "Invalid date",
                        subTitle: "Please select a valid date",
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        typeAnimationContent: AnimationTypeAchievement.fade,
                        borderRadius: 20.0,
                        color: Colors.black,
                        alignment: Alignment.topCenter,
                        duration: Duration(seconds: 3),
                      )..show();
                    } else {
                      Navigator.of(context).pushNamed(
                        ProducerPayment.route,
                        arguments: producer,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
        if (_isLoading)
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Card(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = new NumberFormat("00");
    var prod = Provider.of<ProducersProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width * .45,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        onPageChanged: (i) =>
                            prod.setTime('hour', '${formatter.format(i + 1)}'),
                        children: [
                          for (var i = 1; i < 13; i++)
                            Container(
                              width: double.infinity,
                              height: double.maxFinite,
                              alignment: Alignment.center,
                              child: Text(
                                '${formatter.format(i)}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        onPageChanged: (i) => prod.setTime(
                            'minute', '${formatter.format(i + 1)}'),
                        children: [
                          for (var i = 0; i < 60; i++)
                            Container(
                              width: double.infinity,
                              height: double.maxFinite,
                              alignment: Alignment.center,
                              child: Text(
                                '${formatter.format(i)}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Consumer<ProducersProvider>(
                builder: (context, value, child) => FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${value.time['hour']}:${value.time['minute']}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_drop_up_outlined,
                  color: Colors.white,
                  size: 15,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}

class TimeSelect extends StatefulWidget {
  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  var _label = ['AM', 'PM'];
  var t = 'AM';

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<ProducersProvider>(context, listen: false);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                for (var i = 0; i < _label.length; i++)
                  GestureDetector(
                    onTap: () {
                      prod.setTime('time', _label[i]);
                      setState(() {
                        t = _label[i];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: t == _label[i]
                            ? Theme.of(context).accentColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FittedBox(
                        child: Text(
                          _label[i],
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
