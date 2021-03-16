import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'homescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Row(
          children: [],
        ),
        actions: [
          CircleAvatar(
            maxRadius: 15,
            backgroundImage: NetworkImage('https://fresh-island.org/wp-content/uploads/2020/03/29-1-801x1024.jpg'),
          )
        ],
      ),
    );
  }
}
