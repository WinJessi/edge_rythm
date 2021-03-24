import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/views/ui/events/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAllScreen extends StatelessWidget {
  static const route = '/seeallscreen';
  const SeeAllScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var from = ModalRoute.of(context).settings.arguments as String;
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
              child: Consumer<TicketProvider>(
                builder: (context, value, child) => GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .65,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                  ),
                  children: from == 'UPCOMING'
                      ? [
                          for (var i = 0; i < value.utickets.length; i++)
                            EventCard(ticket: value.utickets[i]),
                        ]
                      : [
                          for (var i = 0; i < value.ptickets.length; i++)
                            EventCard(ticket: value.ptickets[i]),
                        ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
