import 'package:flutter/material.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/core/utils/snak_bar.dart';
import 'package:whats_app/features/chat/state_management/chat_cubit/chat_cubit.dart';

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
                            getImageFile(context).then((file) {
                              if (file != null) {
                                widget.chatCubit.sendFileMessage(
                                  context: context,
                                  file: file,
                                  reciverUid: widget.reciverUid,
                                  messageEnum: MessageEnum.image,
                                );
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
