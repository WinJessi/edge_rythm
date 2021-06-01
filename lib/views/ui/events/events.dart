import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/views/ui/events/event_view.dart';
import 'package:edge_rythm/views/ui/events/see_all.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketProvider>(context, listen: false);
    return Scaffold(
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Hot Events for you.',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(219, 165, 20, 1),
                        Color.fromRGBO(183, 134, 40, 1),
                      ],
                    ),
                  ),
                  child: Icon(Icons.graphic_eq),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Upcoming event',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Spacer(),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(SeeAllScreen.route, arguments: 'UPCOMING'),
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: ticket.upcomingEvents(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  children: [
                    for (var i = 0; i < 2; i++) MyShimmer(),
                  ],
                );
              } else {
                return Consumer<TicketProvider>(
                  builder: (context, value, child) => SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 15),
                        for (var i = 0; i < value.utickets.length; i++)
                          EventCard(ticket: value.utickets[i]),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Popular event',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Spacer(),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(SeeAllScreen.route, arguments: 'POPULAR'),
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: ticket.popularEvents(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  children: [
                    for (var i = 0; i < 2; i++) MyShimmer(),
                  ],
                );
              } else {
                return Consumer<TicketProvider>(
                  builder: (context, value, child) => SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 15),
                        for (var i = 0; i < value.ptickets.length; i++)
                          EventCard(ticket: value.ptickets[i]),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class MyShimmer extends StatelessWidget {
  const MyShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[100],
          highlightColor: Colors.grey[50],
          child: Container(
            width: 220,
            height: 280,
            margin: EdgeInsets.symmetric(horizontal: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white38,
                  ),
                  height: 140,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54,
                  ),
                  height: 45,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54,
                  ),
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54,
                  ),
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    this.ticket,
  }) : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        EventViewScreen.route,
        arguments: ticket,
      ),
      child: Card(
        child: Container(
          width: 220,
          height: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: '#${ticket.id}',
                      child: FancyShimmerImage(
                        imageUrl: ticket.showBanner,
                        boxFit: BoxFit.cover,
                        shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                        shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.showTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        ticket.showDate,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        ticket.showTime,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
