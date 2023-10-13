import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/features/select_contact/repository/select_contact_repository.dart';

class SelectContactController {
  final SelectContactRepository selectContactRepository;
  SelectContactController(this.selectContactRepository);

  Future<void> selectContact(BuildContext context, Contact contact) async {
    await selectContactRepository.selectContact(context, contact);
  }

  Future<List<UserModel>> getAllContactWhatsApp(List<Contact> contacts) async {
   return  await selectContactRepository.getAllContactWhatsApp(contacts);
  }
}
