import 'package:edge_rythm/business_logic/services/providers/chat.dart';
import 'package:edge_rythm/business_logic/services/providers/holiday.dart';
import 'package:edge_rythm/business_logic/services/providers/nav_provider.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/ui/conversation.dart';
import 'package:edge_rythm/views/ui/events/event_view.dart';
import 'package:edge_rythm/views/ui/events/payment.dart';
import 'package:edge_rythm/views/ui/events/see_all.dart';
import 'package:edge_rythm/views/ui/events/ticket.dart';
import 'package:edge_rythm/views/ui/home.dart';
import 'package:edge_rythm/views/ui/producer/home.dart';
import 'package:edge_rythm/views/ui/producers/home.dart';
import 'package:edge_rythm/views/ui/producers/payment.dart';
import 'package:edge_rythm/views/ui/producers/price_list.dart';
import 'package:edge_rythm/views/ui/producers/producer_view.dart';
import 'package:edge_rythm/views/ui/producers/schedule.dart';
import 'package:edge_rythm/views/ui/splash.dart';
import 'package:edge_rythm/views/ui/streaming/home.dart';
import 'package:edge_rythm/views/ui/welcome.dart';
import 'package:edge_rythm/views/ui/what.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences preferences;

  @override
  void initState() {
    initPref();
    super.initState();
  }

  Future initPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: NavProvider()),
        ChangeNotifierProvider.value(value: TicketProvider()),
        ChangeNotifierProvider.value(value: HolidayProvider()),
        ChangeNotifierProvider.value(value: ProducersProvider()),
        ChangeNotifierProvider.value(value: ChatProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'Edge Rythm',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            primaryColor: Color.fromRGBO(55, 55, 55, 1),
            accentColor: Color.fromRGBO(219, 165, 20, 1),
            brightness: Brightness.dark,
            textTheme: TextTheme(
              headline1: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Colors.white,
              ),
              headline2: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.white,
              ),
              headline3: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.black,
              ),
              headline4: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.black,
              ),
              headline5: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
              headline6: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.white,
              ),
              bodyText1: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
              bodyText2: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black,
              ),
              button: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey.shade700,
              selectedItemColor: Color.fromRGBO(219, 165, 20, 1),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
            ),
            cardColor: Color.fromRGBO(55, 55, 55, 1),
            cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Color.fromRGBO(55, 55, 55, 1),
            ),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Color.fromRGBO(242, 241, 243, 1),
              focusColor: Theme.of(context).primaryColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          home: SplashScreen(),
          routes: {
            HomeScreen.route: (_) => HomeScreen(),
            WelcomeScreen.route: (_) => WelcomeScreen(),
            AuthenticationScreen.route: (_) => AuthenticationScreen(),
            WhatDoYouWantScreen.route: (_) => WhatDoYouWantScreen(),
            ProducersHomeScreen.route: (_) => ProducersHomeScreen(),
            StreamingMusicScree.route: (_) => StreamingMusicScree(),
            SeeAllScreen.route: (_) => SeeAllScreen(),
            EventViewScreen.route: (_) => EventViewScreen(),
            PaymentScreen.route: (_) => PaymentScreen(),
            TicketScreen.route: (_) => TicketScreen(),
            ProducersView.route: (_) => ProducersView(),
            ProducersPriceList.route: (_) => ProducersPriceList(),
            ScheduleAppointment.route: (_) => ScheduleAppointment(),
            ProducerPayment.route: (_) => ProducerPayment(),
            ProducerHome.route: (_) => ProducerHome(),
            Conversation.route: (_) => Conversation(),
          },
        ),
      ),
    );
  }
}
