import 'package:edge_rythm/views/ui/events/events.dart';
import 'package:flutter/material.dart';

class SeeAllScreen extends StatelessWidget {
  static const route = '/seeallscreen';
  const SeeAllScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.3),
            ),
            child: Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Upcoming Events\nthis week',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                Spacer(),
                Image.asset('assets/images/more.png'),
                SizedBox(width: 30),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .7,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                children: [
                  for (var i = 0; i < 5; i++) EventCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
