import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/core/permission/check_permission.dart';
import 'package:whats_app/core/utils/snak_bar.dart';
import 'package:whats_app/features/chat/screens/chat_list.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';

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
  late Animation animationHight;
  late Animation animationBorder;

  @override
  void initState() {
    super.initState();
    chatCubit = getIt.get<ChatCubit>(param1: widget.reciverUid);
    WidgetsBinding.instance.addObserver(this);

    //animation
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationHight = Tween(begin: 0.0, end: 1.0).animate(controller);
    animationBorder = Tween(begin: 300.0, end: 20.0).animate(controller);
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (previous, current) {
              return previous.userModel != current.userModel;
            },
            builder: (context, state) {
              return AppBar(
                backgroundColor: appBarColor,
                title: (() {
                  switch (state.stateWidgetUser) {
                    case StateWidget.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case StateWidget.loaded:
                      return Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                child: const Icon(Icons.arrow_back_ios),
                                onTap: () => Navigator.pop(context),
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  state.userModel!.profilePic,
                                ),
                                radius: 20,
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.userModel!.name,
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
                                ),
                                Text(
                                  state.userModel!.isOnline
                                      ? "Online"
                                      : "Offline",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }()),
                leadingWidth: 0,
                leading: Container(),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.video_call),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              );
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const ChatList(),
                  AnimatedBuilder(
                    animation: animationHight,
                    child: GridView(
                      clipBehavior: Clip.hardEdge,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 150,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        customItemBottomSheetMenu(
                          backGround: openDocumentColor,
                          icon: Icons.insert_drive_file_rounded,
                          title: "Document",
                          onTap: () {},
                        ),
                        customItemBottomSheetMenu(
                          backGround: openCameraColor,
                          icon: Icons.camera_alt,
                          title: "Camera",
                          onTap: () {},
                        ),
                        customItemBottomSheetMenu(
                          backGround: openGallaryColor,
                          icon: Icons.image,
                          title: "Gallary",
                          onTap: () {},
                        ),
                        customItemBottomSheetMenu(
                          backGround: openAudioColor,
                          icon: Icons.headphones,
                          title: "Audio",
                          onTap: () {},
                        ),
                      ],
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.bottomRight,
                        height: animationHight.value * 250,
                        margin: const EdgeInsets.all(20).copyWith(bottom: 0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: controller.value <= 0.5 ? Container() : child,
                      );
                    },
                  ),
                ],
              ),
            ),
            CustomInputWithRequordButton(
              chatCubit: chatCubit,
              reciverUid: widget.reciverUid,
              onTapAttach: () {
                if (controller.isCompleted) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customItemBottomSheetMenu({
    required Color backGround,
    required IconData? icon,
    required String title,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backGround,
            ),
            child: Icon(
              icon,
              size: 35,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}

class CustomInputWithRequordButton extends StatefulWidget {
  final ChatCubit chatCubit;
  final String reciverUid;
  final Function()? onTapAttach;
  const CustomInputWithRequordButton({
    super.key,
    required this.chatCubit,
    required this.reciverUid,
    required this.onTapAttach,
  });

  @override
  State<CustomInputWithRequordButton> createState() =>
      _CustomInputWithRequordButtonState();
}

class _CustomInputWithRequordButtonState
    extends State<CustomInputWithRequordButton> {
  TextEditingController textEditingController = TextEditingController();
  bool micOrMessage = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextFormField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.grey,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            await CheckPermission.isStoragePermission()
                                .then((value) {
                              if (value) {
                                getLostData(context).then((file) {
                                  if (file != null) {
                                    widget.chatCubit.sendFileMessage(
                                      context: context,
                                      file: file,
                                      reciverUid: widget.reciverUid,
                                      messageEnum: MessageEnum.image,
                                    );
                                  }
                                });
                              }
                            });
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: widget.onTapAttach,
                          child: const Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                ),
                onChanged: (value) {
                  setState(() {
                    value.isNotEmpty
                        ? micOrMessage = false
                        : micOrMessage = true;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: tabColor,
            child: InkWell(
              onTap: () {
                widget.chatCubit.saveMessage(
                  context: context,
                  reciverUserId: widget.reciverUid,
                  message: textEditingController.text.trim(),
                );
                setState(() {
                  textEditingController.text = '';
                });
              },
              child: Icon(
                micOrMessage ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
            minRadius: 22,
          ),
        ],
      ),
    );
  }
}
