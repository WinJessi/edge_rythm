import 'package:edge_rythm/views/ui/producers/history.dart';
import 'package:edge_rythm/views/ui/producers/notification.dart';
import 'package:edge_rythm/views/ui/producers/producers.dart';
import 'package:edge_rythm/views/ui/producers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/services/providers/nav_provider.dart';

class ProducersHomeScreen extends StatelessWidget {
  static const route = '/producershomescreen';
  const ProducersHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      ProducerScreen(),
      ProducersHistory(),
      ProducersNotification(),
      ProducersSettings(),
    ];

    return Consumer<NavProvider>(
      builder: (context, value, child) => Scaffold(
        body: _screens[value.producerNav],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => value.producerNav = i,
          currentIndex: value.producerNav,
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
