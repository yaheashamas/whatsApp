import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app/core/models/chat_contact.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/controller/chat_controller.dart';

part 'chat_contact_state.dart';

class ChatContactCubit extends Cubit<ChatContactState> {
  final ChatController chatController;

  ChatContactCubit(this.chatController) : super(ChatContactState.inial()) {
    chatController.getChatContact().listen((chats) {
      emit(state.copyWith(
        chatsContacts: chats,
        stateWidgetChatContact: StateWidget.loaded,
      ));
    });
  }
}
