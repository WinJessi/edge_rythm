import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/holiday.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/home.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleAppointment extends StatefulWidget {
  static const route = '/scheduleappointment';
  const ScheduleAppointment({Key key}) : super(key: key);

  @override
  _ScheduleAppointmentState createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  CalendarController _calendarController;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
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
                  calendarController: _calendarController,
                  initialSelectedDay: DateTime.now(),
                  onCalendarCreated: (first, last, format) =>
                      Future.delayed(Duration.zero).then(
                    (value) => pro.setAppointmentParameters(
                      AptMap.date,
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                  onDaySelected: (day, events, holidays) async {
                    Provider.of<HolidayProvider>(context, listen: false)
                        .checkDate(day)
                        .then((value) {
                      if (value.isNotEmpty) {
                        AchievementView(
                          context,
                          title: value.single.name,
                          subTitle:
                              "You can\'t choose ${value.single.date}, it is a public holiday",
                          icon: Icon(Icons.calendar_today, color: Colors.white),
                          typeAnimationContent: AnimationTypeAchievement.fade,
                          borderRadius: 20.0,
                          color: Colors.black,
                          alignment: Alignment.topCenter,
                          duration: Duration(seconds: 3),
                        )..show();
                      } else {
                        if (day.isBefore(DateTime.now())) {
                          AchievementView(
                            context,
                            title: "Invalid date",
                            subTitle:
                                "You can\'t choose a day before current date",
                            icon:
                                Icon(Icons.calendar_today, color: Colors.white),
                            typeAnimationContent: AnimationTypeAchievement.fade,
                            borderRadius: 20.0,
                            color: Colors.black,
                            alignment: Alignment.topCenter,
                            duration: Duration(seconds: 3),
                          )..show();
                        } else {
                          if (day.weekday == 6 || day.weekday == 7) {
                            AchievementView(
                              context,
                              title: "Weekend",
                              subTitle:
                                  "You can\'t book an appointment by weekends",
                              icon: Icon(Icons.calendar_today,
                                  color: Colors.white),
                              typeAnimationContent:
                                  AnimationTypeAchievement.fade,
                              borderRadius: 20.0,
                              color: Colors.black,
                              alignment: Alignment.topCenter,
                              duration: Duration(seconds: 3),
                            )..show();
                          } else {
                            pro.setAppointmentParameters(
                                AptMap.date, day.toIso8601String());
                          }
                        }
                      }
                    });
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
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DurationPicker(
                              snapToMins: 5,
                              duration: Duration(minutes: 60),
                              onChange: (d) {
                                setState(() {});
                              },
                            ),
                          ),
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
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '12:00',
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
                    ),
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
                      confirm(context, producer);
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
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ProducersProvider>(context, listen: false)
          .confirmAppointment(producer.id);
      together();
    } catch (error) {
      throw error;
    }
    setState(() {
      _isLoading = true;
    });
  }

  void together() async {
    setState(() {
      _isLoading = true;
    });
    appointmentSuccess(context);
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
