import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app/core/common/firebase_storage_repository.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/core/models/chat_contact.dart';
import 'package:whats_app/core/models/message.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FireBaseStorageRepository fireBaseStorageRepository;
  ChatRepository(
    this.firebaseFirestore,
    this.firebaseAuth,
    this.fireBaseStorageRepository,
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
        lastMessage: message,
        timeSent: timeSend,
      );

      //to save messages into my collection and reciver collection
      _saveMessageToContactsSubCollection(
        reciverContactId: reciverUserModel.uid,
        messageId: messageId,
        picture: reciverUserModel.profilePic,
        username: reciverUserModel.name,
        message: message,
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
    required String lastMessage,
    required DateTime timeSent,
  }) async {
    //this help display message for reciver
    // users -> reciever user id => chats -> current user id -> set data
    var reciverChatContact = ChatContact(
      contactId: userSender.uid,
      picName: userSender.profilePic,
      name: userSender.name,
      lastMessage: lastMessage,
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
      lastMessage: lastMessage,
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
    required String message,
    required DateTime timeSent,
    required MessageEnum messageType,
  }) async {
    Message messageModel = Message(
      senderUid: firebaseAuth.currentUser!.uid,
      reciverUid: reciverContactId,
      messageUid: messageId,
      message: message,
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
        .set(messageModel.toMap());
    // for reciver
    await firebaseFirestore
        .collection("users")
        .doc(reciverContactId)
        .collection("chats")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(messageModel.toMap());
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

  void updateStateUser(bool status) {
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"isOnline": status});
  }

  sendFileMessage({
    required File file,
    required String reciverUid,
    required BuildContext context,
    required MessageEnum messageEnum,
  }) async {
    try {
      //save fiel in firebase
      var messageId = const Uuid().v1();
      String imageUrl = await fireBaseStorageRepository.storeFileToFireBase(
        "chats/${messageEnum.type}/${firebaseAuth.currentUser!.uid}/$reciverUid/$messageId",
        file,
      );

      //get revicer and sender data
      var senderUser = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      var reciverUser =
          await firebaseFirestore.collection("users").doc(reciverUid).get();
      UserModel userReciver = UserModel.fromMap(reciverUser.data()!);
      UserModel userSender = UserModel.fromMap(senderUser.data()!);
      var timeSent = DateTime.now();
      _saveMessageToContactsSubCollection(
        reciverContactId: reciverUid,
        messageId: messageId,
        picture: userReciver.profilePic,
        username: userReciver.name,
        message: imageUrl,
        timeSent: timeSent,
        messageType: messageEnum,
      );

      String lastMessage = "";
      switch (messageEnum) {
        case MessageEnum.image:
          lastMessage = "📸 Image";
          break;
        case MessageEnum.video:
          lastMessage = "📹 Vider";
          break;
        case MessageEnum.audio:
          lastMessage = "🎤 Audeo";
          break;
        case MessageEnum.gif:
          lastMessage = "🏞️ Gif";
          break;
        default:
      }
      _saveDataToContactsSubCollection(
        userSender: userSender,
        userReciver: userReciver,
        lastMessage: lastMessage,
        timeSent: timeSent,
      );
    } catch (e) {
      showSnakBar(context: context, content: e.toString());
    }
  }
}
