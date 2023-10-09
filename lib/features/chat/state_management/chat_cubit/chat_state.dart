part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final UserModel? userModel;
  final StateWidget stateWidget;

  const ChatState({
    required this.userModel,
    required this.stateWidget,
  });

  factory ChatState.inial() {
    return const ChatState(
      userModel: null,
      stateWidget: StateWidget.loading,
    );
  }

  @override
  List<Object?> get props => [userModel, stateWidget];

  ChatState copyWith({
    UserModel? userModel,
    StateWidget? stateWidget,
  }) {
    return ChatState(
      userModel: userModel ?? this.userModel,
      stateWidget: stateWidget ?? this.stateWidget,
    );
  }
}
