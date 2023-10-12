class ChatContact {
  final String contactId;
  final String picName;
  final String name;
  final String lastMessage;
  final DateTime timeSent;

  ChatContact({
    required this.contactId,
    required this.picName,
    required this.name,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'contactId': contactId,
      'picName': picName,
      'name': name,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      contactId: map['contactId'],
      picName: map['picName'],
      name: map['name'],
      lastMessage: map['lastMessage'],
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
