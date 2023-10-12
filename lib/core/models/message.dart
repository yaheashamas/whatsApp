import 'package:whats_app/core/enums/message_enum.dart';

class Message {
  final String senderUid;
  final String reciverUid;
  final String messageUid;
  final String message;
  final DateTime time;
  final MessageEnum messageType;
  final bool isSeen;

  Message({
    required this.senderUid,
    required this.reciverUid,
    required this.messageUid,
    required this.message,
    required this.time,
    required this.messageType,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'reciverUid': reciverUid,
      'messageUid': messageUid,
      'message': message,
      'time': time,
      'messageType': messageType.type,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUid: map['senderUid'],
      reciverUid: map['reciverUid'],
      messageUid: map['messageUid'],
      message: map['message'],
      time: map['time'].toDate(),
      messageType: (map['messageType'] as String).toEnum(),
      isSeen: map['isSeen'],
    );
  }
}
