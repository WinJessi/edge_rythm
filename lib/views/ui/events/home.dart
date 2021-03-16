import 'package:edge_rythm/views/ui/events/events.dart';
import 'package:edge_rythm/views/ui/events/history.dart';
import 'package:edge_rythm/views/ui/events/notification.dart';
import 'package:edge_rythm/views/ui/events/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/services/providers/nav_provider.dart';

class EventHomeScreen extends StatelessWidget {
  static const route = '/eventscreen';
  const EventHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      EventsScreen(),
      EventsHistory(),
      EventsNotification(),
      EventsSettings(),
    ];
    return Consumer<NavProvider>(
      builder: (context, value, child) => Scaffold(
        body: _screens[value.eventNav],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => value.eventNav = i,
          currentIndex: value.eventNav,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
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
