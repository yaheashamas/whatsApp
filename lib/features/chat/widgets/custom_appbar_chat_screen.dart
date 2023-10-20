import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';

class CustomAppbarChatScreen extends StatelessWidget {
  const CustomAppbarChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
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
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                          Text(
                            state.userModel!.isOnline ? "Online" : "Offline",
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
    );
  }
}
