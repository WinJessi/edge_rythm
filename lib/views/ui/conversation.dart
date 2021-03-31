import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  static const route = '/conversation';
  const Conversation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [CircleAvatar(), SizedBox(width: 15)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Message',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Jay Music',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.black),
                    ),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(),
                    ]),
                  ),
                  Divider(height: .5),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: ListView(
                                reverse: true,
                                children: [
                                  SizedBox(height: 15),
                                  for (var i = 0; i < 11; i++)
                                    i.isEven ? Sender() : Receiver(),
                                ],
                              ),
                            ),
                          ),
                          ChatController(),
                          SizedBox(height: 15)
                        ],
                      ),
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

class Sender extends StatelessWidget {
  const Sender({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 30),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.grey.shade300,
              ),
              child: Text(
                'LOREM IPSUM IS A DUMMY TEXT GENERATED FOR THE PURPOSE OF TEXT PLACE HOLDING',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(maxRadius: 16),
        ],
      ),
    );
  }
}

class Receiver extends StatelessWidget {
  const Receiver({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(maxRadius: 16),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromRGBO(219, 165, 20, .3),
              ),
              child: Text(
                'LOREM IPSUM IS A DUMMY TEXT GENERATED FOR THE PURPOSE OF TEXT PLACE HOLDING LOREM IPSUM IS A DUMMY TEXT GENERATED FOR THE PURPOSE OF TEXT PLACE HOLDING LOREM IPSUM IS A DUMMY TEXT GENERATED FOR THE PURPOSE OF TEXT PLACE HOLDING',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}

class ChatController extends StatelessWidget {
  const ChatController({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                // validator: (value) {
                //   if (!value.contains('@')) return 'Please use a valid email address';
                //   if (value.isEmpty) return 'Email address is empty.';
                //   return null;
                // },
                // onSaved: (value) => auth.saveData(UserMap.email, value),
                keyboardType: TextInputType.emailAddress,

                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Start typing...',
                ),
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              child: Container(
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
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
