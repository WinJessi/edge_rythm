import 'package:edge_rythm/business_logic/model/message.dart';
import 'package:edge_rythm/business_logic/services/providers/chat.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/conversation.dart';
import 'package:edge_rythm/views/ui/producer/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerMessage extends StatelessWidget {
  const ProducerMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<UserProvider>(
            builder: (context, value, child) => GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ProducerProfile.route),
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    value.producer.photo,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ChatProvider>(context, listen: false)
            .getMessage(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<ChatProvider>(
              builder: (context, value, child) => value.messages.length < 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/chat.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'You don’t have any messages\nnow check back later',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'My Messages',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        SizedBox(height: 15),
                        for (var i = 0; i < value.messages.length; i++)
                          MessageCard(model: value.messages[i]),
                      ],
                    ),
            );
          }
        },
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key key,
    this.model,
    this.from,
  }) : super(key: key);

  final MessageModel model;
  final String from;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Conversation.route,
          arguments: [model.chat.receiver, model.receiver.name]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage(
                      'https://pngimage.net/wp-content/uploads/2018/06/listening-icon-png-3.png'),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        model.receiver.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 5),
                      Text(
                        model.chat.message,
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
