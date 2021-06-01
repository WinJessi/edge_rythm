import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/producers/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  static const route = '/user_profile';
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'My Profile',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'profile',
                  child: Container(
                    height: 150,
                    width: 150,
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
              ],
            ),
            SizedBox(height: 10),
            Hero(
              tag: 'edit_profile',
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(ProfileEdit.route),
                child: Text(
                  'Edit profile',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 243, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text(
                  value.userModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 243, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.mail, color: Colors.black),
                title: Text(
                  value.userModel.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 243, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.call, color: Colors.black),
                title: Text(
                  value.userModel.phone,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
