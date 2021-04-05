import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/chat.dart';
import 'package:edge_rythm/views/ui/conversation.dart';
import 'package:edge_rythm/views/ui/producers/price_list.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducersView extends StatefulWidget {
  static const route = '/producer_evenrt';
  ProducersView({Key key}) : super(key: key);

  @override
  _ProducersViewState createState() => _ProducersViewState();
}

class _ProducersViewState extends State<ProducersView> {
  @override
  Widget build(BuildContext context) {
    var producer = ModalRoute.of(context).settings.arguments as Producers;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Stack(
              children: [
                Hero(
                  tag: 'P${producer.id}',
                  child: FancyShimmerImage(
                    imageUrl: producer.photo,
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                    height: double.maxFinite,
                    shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                    shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
                  ),
                ),
                Container(color: Colors.black26),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: 'producer_name',
                        child: Text(
                          producer.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        producer.genre,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '4.5',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.star, size: 15),
                          SizedBox(width: 5),
                          Container(
                            width: 5,
                            height: 5,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            producer.location,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    Conversation.route,
                    arguments: [producer.producerID, producer.name],
                  ).then((value) =>
                      Provider.of<ChatProvider>(context, listen: false)
                          .cancelTimer()),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(219, 165, 20, 1),
                          Color.fromRGBO(183, 134, 40, 1),
                        ],
                      ),
                    ),
                    child: Icon(Icons.mail_outline),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white, endIndent: 15, indent: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Music produced',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        '30',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Experience',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        '3years+',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Awards',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        '3',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(indent: 15, color: Colors.white, endIndent: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'About',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              producer.about,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Location',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Text(
                        producer.location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(height: 1.5, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FancyShimmerImage(
                      imageUrl:
                          'https://cdn.vox-cdn.com/thumbor/rgnZj-wJtFBWeGIq4beR04GU-8M=/1400x788/filters:format(png)/cdn.vox-cdn.com/uploads/chorus_asset/file/19700731/googlemaps.png',
                      boxFit: BoxFit.cover,
                      width: double.infinity,
                      height: double.maxFinite,
                      shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                      shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GradientRaisedButton(
              child: Text(
                'Go to booking pricelist',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => Navigator.of(context).pushNamed(
                ProducersPriceList.route,
                arguments: producer,
              ),
            ),
          )
        ],
      ),
    );
  }
}
