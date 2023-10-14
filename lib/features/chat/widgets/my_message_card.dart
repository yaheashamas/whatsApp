import 'package:flutter/material.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/features/chat/widgets/message_text_or_image.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum messageEnum;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.messageEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: messageColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageTextOrImage(
                  data: message,
                  messageEnum: messageEnum,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.done_all,
                      size: 20,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
