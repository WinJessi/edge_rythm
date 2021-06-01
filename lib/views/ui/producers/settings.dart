import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/ui/producers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducersSettings extends StatelessWidget {
  const ProducersSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(UserProfile.route),
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              prod.logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AuthenticationScreen.route, (route) => false);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
