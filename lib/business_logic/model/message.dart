import 'package:edge_rythm/business_logic/model/chat.dart';
import 'package:edge_rythm/business_logic/model/user.dart';

class MessageModel {
  final UserModel sender;
  final UserModel receiver;
  final ChatModel chat;

  MessageModel({
    this.sender,
    this.chat,
    this.receiver,
  });

  MessageModel.fromJson(Map<String, dynamic> map)
      : sender = map[MessageMap.sender],
        receiver = map[MessageMap.receiver],
        chat = map[MessageMap.chat];
}

class MessageMap {
  static const chat = 'chat';
  static const sender = 'sender';
  static const receiver = 'receiver';
}
