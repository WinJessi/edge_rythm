import 'package:edge_rythm/business_logic/model/chat.dart';
import 'package:edge_rythm/business_logic/services/providers/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conversation extends StatelessWidget {
  static const route = '/conversation';
  const Conversation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var receiver = ModalRoute.of(context).settings.arguments as List<dynamic>;

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
                    child: Hero(
                      tag: 'producer_name',
                      child: Text(
                        receiver[1],
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
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
                              child: StreamBuilder(
                                  stream: Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .allMessages(receiver[0]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Image.asset(
                                          'assets/images/loading.gif',
                                          width: 150,
                                          height: 150,
                                        ),
                                      );
                                    } else {
                                      var data =
                                          snapshot.data as List<ChatModel>;
                                      return ListView(
                                        children: [
                                          SizedBox(height: 15),
                                          for (var i = 0; i < data.length; i++)
                                            data[i].receiver == receiver[0]
                                                ? Sender(model: data[i])
                                                : Receiver(model: data[i]),
                                        ],
                                      );
                                    }
                                  }),
                            ),
                          ),
                          ChatController(receiver: receiver[0]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Sender extends StatefulWidget {
  const Sender({
    Key key,
    this.model,
  }) : super(key: key);

  final ChatModel model;

  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.isDismissed;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Padding(
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
                  widget.model.message,
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
      ),
    );
  }
}

class Receiver extends StatefulWidget {
  const Receiver({
    Key key,
    this.model,
  }) : super(key: key);

  final ChatModel model;

  @override
  _ReceiverState createState() => _ReceiverState();
}

class _ReceiverState extends State<Receiver> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Padding(
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
                  widget.model.message,
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
      ),
    );
  }
}

class ChatController extends StatefulWidget {
  const ChatController({
    Key key,
    this.receiver,
  }) : super(key: key);

  final int receiver;

  @override
  _ChatControllerState createState() => _ChatControllerState();
}

class _ChatControllerState extends State<ChatController> {
  GlobalKey<FormState> _form = new GlobalKey();

  void sendMessage(ChatProvider provider) async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();

    try {
      await provider.sendMessage();
      _form.currentState.reset();
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    var chat = Provider.of<ChatProvider>(context, listen: false);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return '';
                    return null;
                  },
                  onSaved: (value) {
                    chat.setBody(ChatMap.message, value);
                    chat.setBody(ChatMap.receiver, '${widget.receiver}');
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: 'Start typing...',
                  ),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () => sendMessage(chat),
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
      ),
    );
  }
}
