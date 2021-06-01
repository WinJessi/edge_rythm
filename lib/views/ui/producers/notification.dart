import 'package:edge_rythm/business_logic/services/providers/chat.dart';
import 'package:edge_rythm/views/ui/producer/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducersNotification extends StatelessWidget {
  const ProducersNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
