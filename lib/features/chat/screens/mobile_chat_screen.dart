import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/widgets/chat_list.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';

class MobileChatScreen extends StatefulWidget {
  final UserModel user;
  const MobileChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  late ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    chatCubit = getIt.get<ChatCubit>(param1: widget.user.uid);
  }

  @override
  void dispose() {
    chatCubit.close();
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
                  switch (state.stateWidget) {
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
            const Expanded(child: ChatList()),
            SafeArea(
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.emoji_emotions,
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.money,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
