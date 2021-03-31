import 'package:edge_rythm/business_logic/services/providers/nav_provider.dart';
import 'package:edge_rythm/views/ui/producer/message.dart';
import 'package:edge_rythm/views/ui/producer/producer_home.dart';
import 'package:edge_rythm/views/ui/producer/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerHome extends StatelessWidget {
  static const route = '/producerhome';
  const ProducerHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ProducerHomeScreen(),
      ProducerMessage(),
      ProducerSetting(),
    ];

    return Consumer<NavProvider>(
      builder: (context, value, child) => Scaffold(
        body: _screens[value.producer],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => value.producer = i,
          currentIndex: value.producer,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.history_outlined),
            //   label: 'History',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
