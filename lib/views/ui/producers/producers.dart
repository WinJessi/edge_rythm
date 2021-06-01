import 'dart:ui';

import 'package:edge_rythm/business_logic/model/category.dart';
import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/producers/producer_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerScreen extends StatefulWidget {
  const ProducerScreen({Key key}) : super(key: key);

  @override
  _ProducerScreenState createState() => _ProducerScreenState();
}

class _ProducerScreenState extends State<ProducerScreen> {
  // TextEditingController search = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var producer = Provider.of<ProducersProvider>(context, listen: false);
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
                      // controller: search,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          producer.realtimeSearch(value);
                          // setState(() {});
                        }
                      },
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
            child: FutureBuilder(
              future: Future.wait([
                Provider.of<ProducersProvider>(context, listen: false)
                    .fetchCategories(context),
                Provider.of<ProducersProvider>(context, listen: false)
                    .fetchProducers(context),
              ]),
              builder: (context, snapshot) {
                return Consumer<ProducersProvider>(
                  builder: (context, value, child) => DefaultTabController(
                    length: value.categories.length,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TabBar(
                            isScrollable: true,
                            tabs: value.categories
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(e.category),
                                    ))
                                .toList(),
                            indicatorSize: TabBarIndicatorSize.label,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: value.categories
                                .map((e) => CategoryView(category: e))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key key,
    this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ProducersProvider>(context, listen: false)
            .getProducer(category.category),
        builder: (context, snapshot) {
          if (snapshot.data == null) return SizedBox();
          var data = snapshot.data as List<Producers>;
          return ListView(
            children: [
              for (var i = 0; i < data.length; i++)
                ProducerCard(producers: data[i]),
              SizedBox(height: 15),
            ],
          );
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
