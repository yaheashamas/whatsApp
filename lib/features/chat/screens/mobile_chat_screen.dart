import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/widgets/inkwell/custom_inkwell.dart';
import 'package:whats_app/features/chat/screens/chat_list.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';
import 'package:whats_app/features/chat/widgets/custom_appbar_chat_screen.dart';
import 'package:whats_app/features/chat/widgets/custom_buttom_sheet_bar.dart';
import 'package:whats_app/features/chat/widgets/custom_input_with_requord_button.dart';

class MobileChatScreen extends StatefulWidget {
  final String reciverUid;
  const MobileChatScreen({
    Key? key,
    required this.reciverUid,
  }) : super(key: key);

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late ChatCubit chatCubit;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    chatCubit = getIt.get<ChatCubit>(param1: widget.reciverUid);
    WidgetsBinding.instance.addObserver(this);
    //animation
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        chatCubit.updateStateUser(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        chatCubit.updateStateUser(false);
        break;
      default:
    }
  }


  toggleStatusContainer({bool screen = false}) {
    if (screen) {
      controller.reverse();
    } else {
      if (controller.isCompleted) {
        controller.reverse();
      } else {
        controller.forward();
      }
    }
  }

  @override
  void dispose() {
    chatCubit.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatCubit,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppbarChatScreen(),
        ),
        body: CustomInkWell(
          onTap: () => toggleStatusContainer(screen: true),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const ChatList(),
                    CustomButtomSheetBar(
                      controller: controller,
                    ),
                  ],
                ),
              ),
              CustomInputWithRequordButton(
                chatCubit: chatCubit,
                reciverUid: widget.reciverUid,
                onTapAttach: () => toggleStatusContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
