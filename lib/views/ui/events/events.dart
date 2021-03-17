import 'package:edge_rythm/views/ui/events/event_view.dart';
import 'package:edge_rythm/views/ui/events/see_all.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SeeAllScreen.route),
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 15),
                for (var i = 0; i < 6; i++) EventCard(),
                SizedBox(width: 15),
              ],
            ),
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
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 15),
                for (var i = 0; i < 6; i++) EventCard(),
                SizedBox(width: 15),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(EventViewScreen.route),
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
                    child: FancyShimmerImage(
                      imageUrl:
                          'https://www.theo2.co.uk/assets/img/List_Thumb_215x215-21ad3f55eb.png',
                      boxFit: BoxFit.cover,
                      shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                      shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
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
                        'Davido at the O2 london',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'Friday 17th April 2020',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '2:00 PM',
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
