import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whats_app/core/extensions/string_extension.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

class SelectContactRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  SelectContactRepository(this.firebaseFirestore,this.firebaseAuth);

  Future<List<UserModel>> getAllContactWhatsApp(
    List<Contact> contacts,
  ) async {
    var users = await firebaseFirestore.collection("users").get();
    List<UserModel> userHasWhatsUp = [];

    for (var phone in contacts) {
      var phoneNumber = phone.phones[0].number.removeAllCaracter;
      for (var user in users.docs) {
        UserModel userModel = UserModel.fromMap(user.data());
        if (userModel.phoneNumber.removeAllCaracter == phoneNumber) {
          userHasWhatsUp.add(userModel);
        } else {
          UserModel userModel = UserModel(
            name: phone.displayName,
            uid: "",
            profilePic: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
            isOnline: false,
            phoneNumber: phone.phones[0].number.removeAllCaracter,
            groupId: const [],
            invite: true,
          );
          userHasWhatsUp.add(userModel);
        }
      }
    }
    userHasWhatsUp.sort(
      (a, b) => a.invite.toString().compareTo(b.invite.toString()),
    );
    userHasWhatsUp.removeWhere((users) => users.uid == firebaseAuth.currentUser!.uid);
    return userHasWhatsUp.unique((element) => element.phoneNumber);
  }

  Future<void> selectContact(BuildContext context, Contact contact) async {
    bool isExsist = false;
    var users = await firebaseFirestore.collection("users").get();
    for (var element in users.docs) {
      var user = UserModel.fromMap(element.data());
      if (user.phoneNumber.removeAllCaracter ==
          contact.phones[0].number.removeAllCaracter) {
        isExsist = true;
        Navigator.pushNamed(context, RouteList.chat, arguments: user.uid);
        break;
      }
    }
    if (!isExsist) {
      showSnakBar(
        context: context,
        content: "this user doesn't have a WhatsApp",
      );
    }
  }
}
