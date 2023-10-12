part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<Message>? messages;
  final StateWidget stateWidgetMessage;

  final UserModel? userModel;
  final StateWidget stateWidgetUser;

  const ChatState({
    required this.messages,
    required this.stateWidgetMessage,
    required this.userModel,
    required this.stateWidgetUser,
  });

  factory ChatState.inial() {
    return const ChatState(
      messages: [],
      stateWidgetMessage: StateWidget.loading,
      userModel: null,
      stateWidgetUser: StateWidget.loading,
    );
  }

  @override
  List<Object?> get props => [messages, stateWidgetMessage, userModel, stateWidgetUser];

  ChatState copyWith({
    List<Message>? messages,
    StateWidget? stateWidgetMessage,
    UserModel? userModel,
    StateWidget? stateWidgetUser,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      stateWidgetMessage: stateWidgetMessage ?? this.stateWidgetMessage,
      userModel: userModel ?? this.userModel,
      stateWidgetUser: stateWidgetUser ?? this.stateWidgetUser,
    );
  }
}
