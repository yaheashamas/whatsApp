import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/core/models/message.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/controller/chat_controller.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatController chatController;
  String uID;

  ChatCubit({
    required this.chatController,
    required this.uID,
  }) : super(ChatState.inial()) {
    chatController.getUserInfo(uID).listen((user) {
      if (isClosed) return;
      emit(state.copyWith(
        userModel: user,
        stateWidgetUser: StateWidget.loaded,
      ));
    });

    chatController.getMessage(uID).listen((messages) {
      if (isClosed) return;
      emit(state.copyWith(
        messages: messages,
        stateWidgetMessage: StateWidget.loaded,
      ));
    });
  }

  void saveMessage({
    required BuildContext context,
    required String reciverUserId,
    required String message,
  }) async {
    if (message.isNotEmpty && message.trim() != "") {
      chatController.saveMessage(
        context: context,
        reciverUserId: reciverUserId,
        message: message.trim(),
      );
    }
  }

  void updateStateUser(bool status) {
    chatController.updateStateUser(status);
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String reciverUid,
    required MessageEnum messageEnum,
  }) {
    chatController.sendFileMessage(
      context: context,
      file: file,
      reciverUid: reciverUid,
      messageEnum: messageEnum,
    );
  }
}
