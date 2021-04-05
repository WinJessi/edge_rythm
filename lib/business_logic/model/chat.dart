class ChatModel {
  final int id;
  final int sender;
  final int receiver;
  final String message;
  final DateTime created;

  ChatModel({
    this.id,
    this.message,
    this.created,
    this.receiver,
    this.sender,
  });

  ChatModel.fromJson(Map<String, dynamic> map)
      : sender = int.parse(map[ChatMap.sender].toString()),
        id = int.parse(map[ChatMap.id].toString()),
        receiver = int.parse(map[ChatMap.receiver].toString()),
        // created = DateTime.fromMicrosecondsSinceEpoch(map[ChatMap.created]),
        created = DateTime.parse(map[ChatMap.created]),
        message = map[ChatMap.message];
}

class ChatMap {
  static const receiver = 'receiver';
  static const message = 'message';
  static const sender = 'sender';
  static const read = 'read';
  static const created = 'created_at';
  static const id = 'id';
}
