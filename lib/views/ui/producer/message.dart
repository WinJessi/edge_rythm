import 'package:edge_rythm/views/ui/conversation.dart';
import 'package:flutter/material.dart';

class ProducerMessage extends StatelessWidget {
  const ProducerMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: [CircleAvatar(), SizedBox(width: 15)],
        ),
        body: ListView(
          children: [
            SizedBox(height: 15),
            for (var i = 0; i < 2; i++) MessageCard(),
          ],
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Image.asset(
        //       'assets/images/chat.png',
        //       width: 150,
        //       height: 150,
        //     ),
        //     SizedBox(height: 30),
        //     Text(
        //       'You don’t have any messages\nnow check back later',
        //       style: Theme.of(context).textTheme.bodyText1,
        //       textAlign: TextAlign.center,
        //     ),
        //   ],
        // ),
        );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Conversation.route),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //   child: Text(
          //     '$time',
          //     style: Theme.of(context).textTheme.headline2,
          //   ),
          // ),
          // for (var i = 0; i < appointment.length; i++)
          Container(
            // height: 80,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color:
                  // date.isBefore(DateTime.now())
                  //     ? Colors.red.withOpacity(.3)
                  //     :
                  Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage('https://pngimage.net/wp-content/uploads/2018/06/listening-icon-png-3.png'),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'appointment.producer.name',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Lorem ipsum is a dummy text generated for the purpose of text place holding',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  ),
                  child: FittedBox(
                    child: Text(
                      '2',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
