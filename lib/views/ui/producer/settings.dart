import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:edge_rythm/views/ui/producer/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerSetting extends StatelessWidget {
  const ProducerSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<UserProvider>(
            builder: (context, value, child) => GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ProducerProfile.route),
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    value.producer.photo,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'My Settings',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(ProducerProfile.route),
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
