part of 'chat_contact_cubit.dart';

class ChatContactState extends Equatable {
 //get all chat
  final List<ChatContact> chatsContacts;
  final StateWidget stateWidgetChatContact;

  const ChatContactState({
    required this.chatsContacts,
    required this.stateWidgetChatContact,
  });

  factory ChatContactState.inial() {
    return const ChatContactState(
      chatsContacts: [],
      stateWidgetChatContact: StateWidget.loading,
    );
  }

  @override
  List<Object?> get props => [chatsContacts, stateWidgetChatContact];

  ChatContactState copyWith({
    List<ChatContact>? chatsContacts,
    StateWidget? stateWidgetChatContact,
  }) {
    return ChatContactState(
      chatsContacts: chatsContacts ?? this.chatsContacts,
      stateWidgetChatContact: stateWidgetChatContact ?? this.stateWidgetChatContact,
    );
  }
}
