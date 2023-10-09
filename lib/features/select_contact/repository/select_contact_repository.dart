import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whats_app/core/extensions/string_extension.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

class SelectContactRepository {
  final FirebaseFirestore firebaseFirestore;
  SelectContactRepository(this.firebaseFirestore);

  Future<void> selectContact(BuildContext context, Contact contact) async {
    bool isExsist = false;
    var users = await firebaseFirestore.collection("users").get();
    for (var element in users.docs) {
      var user = UserModel.fromMap(element.data());
      if (user.phoneNumber.removeAllCaracter ==
          contact.phones[0].number.removeAllCaracter) {
        isExsist = true;
        Navigator.pushNamed(context, RouteList.chat,arguments:user);
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
