import 'package:edge_rythm/business_logic/services/providers/nav_provider.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/ui/home.dart';
import 'package:edge_rythm/views/ui/splash.dart';
import 'package:edge_rythm/views/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NavProvider()),
      ],
      child: MaterialApp(
        title: 'Edge Rythm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color.fromRGBO(55, 55, 55, 1),
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
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            unselectedItemColor: Color.fromRGBO(55, 55, 55, 1),
            selectedItemColor: Color.fromRGBO(219, 165, 20, 1),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
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
        },
      ),
    );
  }
}
