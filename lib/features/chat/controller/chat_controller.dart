import 'package:flutter/material.dart';
import 'package:whats_app/core/models/chat_contact.dart';
import 'package:whats_app/core/models/message.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/features/chat/repository/chat_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  ChatController(this.chatRepository);

  Stream<UserModel> getUserInfo(String uid) async* {
    yield* chatRepository.getUserInfo(uid);
  }

  void saveMessage({
    required BuildContext context,
    required String reciverUserId,
    required String message,
  }) async {
    return chatRepository.sendTextMessage(
      context: context,
      reciverUserId: reciverUserId,
      message: message,
    );
  }

  Stream<List<ChatContact>> getChatContact() async* {
    yield* chatRepository.getChatContact();
  }

  Stream<List<Message>> getMessage(String reciverUid) async* {
    yield* chatRepository.getMessages(reciverUid);
  }

  void updateStateUser(bool status) {
    chatRepository.updateStateUser(status);
  }
}
