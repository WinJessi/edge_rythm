import 'dart:ui';

import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/producers/producer_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProducerScreen extends StatelessWidget {
  const ProducerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Producers', 'Sound Engineer'];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Find the best Producers',
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
          SizedBox(height: 5),
          Expanded(
            child: DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TabBar(
                      tabs: categories
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(e),
                              ))
                          .toList(),
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categories.map((e) => CategoryView()).toList(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ProducersProvider>(context, listen: false)
            .fetchProducers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[100],
                    highlightColor: Colors.grey[50],
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                            ),
                            height: 70,
                          ),
                          SizedBox(width: 30),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Consumer<ProducersProvider>(
              builder: (context, value, child) => ListView(
                children: [
                  for (var i = 0; i < value.producers.length; i++)
                    ProducerCard(producers: value.producers[i]),
                  SizedBox(height: 15),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ProducerCard extends StatelessWidget {
  const ProducerCard({
    Key key,
    this.producers,
  }) : super(key: key);

  final Producers producers;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ProducersView.route,
        arguments: producers,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Hero(
              tag: 'P${producers.id}',
              child: CircleAvatar(
                maxRadius: 30,
                backgroundImage: NetworkImage(producers.photo),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    producers.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Top rated',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(8),
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        producers.location,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '4.5',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.star, size: 15),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
