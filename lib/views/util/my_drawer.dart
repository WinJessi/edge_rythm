import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Theme(
      data: new ThemeData(canvasColor: Colors.white),
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            ListTile(leading: CircleAvatar(maxRadius: 16)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                user.userM.name,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.black54),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'About',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Terms of use',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Privacy',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Help center',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                'Sign in as producer',
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
            ListTile(
              onTap: () async {
                user.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthenticationScreen.route, (route) => false);
              },
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
