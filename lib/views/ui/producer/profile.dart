import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/producer/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerProfile extends StatelessWidget {
  static const route = '/producer_profile';
  const ProducerProfile({Key key}) : super(key: key);

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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
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
                      child: Image.network(
                        value.producer.photo,
                        fit: BoxFit.cover,
                      ),
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
                    Navigator.of(context).pushNamed(ProducerProfileEdit.route),
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
                  value.producer.name,
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
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 243, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(Icons.my_location, color: Colors.black),
                title: Text(
                  value.producer.location,
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
                leading: Icon(Icons.music_note, color: Colors.black),
                title: Text(
                  value.producer.genre,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 243, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 10),
                  Text(
                    value.producer.about,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
