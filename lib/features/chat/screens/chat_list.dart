import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/core/state_management/uid_hydrated/uid_hydrated.dart';
import 'package:whats_app/features/chat/widgets/my_message_card.dart';
import 'package:whats_app/features/chat/widgets/sender_message_card.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) {
        return previous.messages != current.messages;
      },
      builder: (context, state) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        });

        if (state.stateWidgetMessage == StateWidget.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: state.messages!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var timeSent = DateFormat.Hm().format(
              state.messages![index].time,
            );
            if (state.messages![index].senderUid == UidCubit().state) {
              return MyMessageCard(
                message: state.messages![index].message.toString(),
                date: timeSent,
                messageEnum: state.messages![index].messageType,
              );
            }
            return SenderMessageCard(
              message: state.messages![index].message.toString(),
              date: timeSent,
              messageEnum: state.messages![index].messageType,
            );
          },
        );
      },
    );
  }
}
