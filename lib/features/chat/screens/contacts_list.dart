import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/extensions/string_extension.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/chat/screens/mobile_chat_screen.dart';
import 'package:whats_app/features/chat/state_management/chat_contact_cubit/chat_contact_cubit.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  late ChatContactCubit chatContactCubit;

  @override
  void initState() {
    super.initState();
    chatContactCubit = getIt.get<ChatContactCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    chatContactCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatContactCubit,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: BlocBuilder<ChatContactCubit, ChatContactState>(
          buildWhen: (previous, current) {
            return previous.chatsContacts != current.chatsContacts;
          },
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.chatsContacts.length,
              itemBuilder: (context, index) {
                var user = state.chatsContacts[index];
                var timeSent = DateFormat.Hm().format(
                  state.chatsContacts[index].timeSent,
                );
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MobileChatScreen(
                              reciverUid: user.contactId,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            user.name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              user.lastMessage.toString().cutText,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              user.picName.toString(),
                            ),
                            radius: 30,
                          ),
                          trailing: Text(
                            timeSent.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: dividerColor, indent: 85),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
