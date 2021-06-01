import 'package:edge_rythm/views/ui/events/home.dart';
import 'package:edge_rythm/views/ui/producers/home.dart';
import 'package:edge_rythm/views/ui/producers/profile.dart';
import 'package:edge_rythm/views/util/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/services/providers/nav_provider.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'homescreen';
  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [ProducersHomeScreen(), EventHomeScreen()];
    List<String> _label = ['Producers', 'Events'];
    return Consumer<NavProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: [
                    for (var i = 0; i < _label.length; i++)
                      GestureDetector(
                        onTap: () => value.topBar = i,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: value.topBar == i
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: FittedBox(
                            child: Text(_label[i]),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(UserProfile.route),
              child: Hero(
                tag: 'profile',
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: .5,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/rhythm.png',
                  ),
                ),
              ),
            ),
            SizedBox(width: 15)
          ],
        ),
        drawer: MyDrawer(),
        body: _screens[value.topBar],
      ),
    );
  }
}
