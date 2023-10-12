import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/core/models/chat_contact.dart';
import 'package:whats_app/core/models/message.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  ChatRepository(
    this.firebaseFirestore,
    this.firebaseAuth,
  );

  Stream<UserModel> getUserInfo(String uid) async* {
    yield* firebaseFirestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((user) => UserModel.fromMap(user.data()!));
  }

  //handel chat messages
  void sendTextMessage({
    required BuildContext context,
    required String reciverUserId,
    required String message,
  }) async {
    try {
      //user -> sender_id -> recive_id -> messages -> message_id -> storage_id
      var timeSend = DateTime.now();
      var senderUser = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      var reciverUser =
          await firebaseFirestore.collection("users").doc(reciverUserId).get();
      UserModel reciverUserModel = UserModel.fromMap(reciverUser.data()!);
      UserModel senderUserModel = UserModel.fromMap(senderUser.data()!);
      var messageId = const Uuid().v4();

      // to save the last message
      _saveDataToContactsSubCollection(
        userSender: senderUserModel,
        userReciver: reciverUserModel,
        message: message,
        timeSent: timeSend,
      );

      //to save messages into my collection and reciver collection
      _saveMessageToContactsSubCollection(
        reciverContactId: reciverUserModel.uid,
        messageId: messageId,
        picture: reciverUserModel.profilePic,
        username: reciverUserModel.name,
        lastMessage: message,
        timeSent: timeSend,
        messageType: MessageEnum.text,
      );
    } catch (e) {
      showSnakBar(context: context, content: e.toString());
    }
  }

  _saveDataToContactsSubCollection({
    required UserModel userSender,
    required UserModel userReciver,
    required String message,
    required DateTime timeSent,
  }) async {
    //this help display message for reciver
    // users -> reciever user id => chats -> current user id -> set data
    var reciverChatContact = ChatContact(
      contactId: userSender.uid,
      picName: userSender.profilePic,
      name: userSender.name,
      lastMessage: message,
      timeSent: timeSent,
    );
    await firebaseFirestore
        .collection("users")
        .doc(userReciver.uid)
        .collection("chats")
        .doc(userSender.uid)
        .set(reciverChatContact.toMap());
    //this help display message for us
    // users -> current user id = chats -> reciever user id -> set data
    var senderChatContact = ChatContact(
      contactId: userReciver.uid,
      picName: userReciver.profilePic,
      name: userReciver.name,
      lastMessage: message,
      timeSent: timeSent,
    );
    await firebaseFirestore
        .collection("users")
        .doc(userSender.uid)
        .collection("chats")
        .doc(userReciver.uid)
        .set(senderChatContact.toMap());
  }

  _saveMessageToContactsSubCollection({
    required String reciverContactId,
    required String messageId,
    required String picture,
    required String username,
    required String lastMessage,
    required DateTime timeSent,
    required MessageEnum messageType,
  }) async {
    Message message = Message(
      senderUid: firebaseAuth.currentUser!.uid,
      reciverUid: reciverContactId,
      messageUid: messageId,
      message: lastMessage,
      time: timeSent,
      messageType: messageType,
      isSeen: false,
    );
    //for me
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("chats")
        .doc(reciverContactId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
    // for reciver
    await firebaseFirestore
        .collection("users")
        .doc(reciverContactId)
        .collection("chats")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
  }

  Stream<List<ChatContact>> getChatContact() async* {
    yield* firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((chat) async {
      List<ChatContact> contacts = [];
      for (var document in chat.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firebaseFirestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ChatContact(
            name: user.name,
            picName: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  Stream<List<Message>> getMessages(String reciverUid) async* {
    yield* firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("chats")
        .doc(reciverUid)
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .map(
      (chat) {
        List<Message> messages = [];
        for (var document in chat.docs) {
          messages.add(Message.fromMap(document.data()));
        }
        return messages;
      },
    );
  }
}
