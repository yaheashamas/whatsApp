import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/select_contact/controller/select_contact_controller.dart';

part 'select_contact_state.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  final SelectContactController selectContactController;
  SelectContactCubit(
    this.selectContactController,
  ) : super(SelectContactState.inail());

  getAllContact() async {
    if (await FlutterContacts.requestPermission()) {
      emit(state.copyWith(stateWidget: StateWidget.loading));
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      emit(state.copyWith(contacts: contacts, stateWidget: StateWidget.loaded));
    }
  }

  Future<void> selectUser(BuildContext context,Contact contact) async {
    await selectContactController.selectContact(context,contact);
  }
}
