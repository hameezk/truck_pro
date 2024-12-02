class ChatroomModel {
  String? chatroomId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatroomModel({
    this.lastMessage,
    this.chatroomId,
    this.participants,
  });

  ChatroomModel.fromMap(Map<String, dynamic> map) {
    chatroomId = map["chatroomId"];
    participants = map["participants"];
    lastMessage = map["lastMessage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomId": chatroomId,
      "participants": participants,
      "lastMessage": lastMessage,
    };
  }
}

class ChatModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  String? createdon;

  ChatModel({
    this.messageId,
    this.sender,
    this.text,
    this.seen,
    this.createdon,
  });

  ChatModel.fromMap(Map<String, dynamic> map) {
    messageId = map["messageId"];
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createdon = map["createdOn"];
  }

  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "sender": sender,
      "text": text,
      "seen": seen,
      "createdOn": createdon,
    };
  }
}
