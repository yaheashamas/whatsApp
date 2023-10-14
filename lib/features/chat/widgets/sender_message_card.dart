import 'package:flutter/material.dart';
import 'package:whats_app/core/enums/message_enum.dart';
import 'package:whats_app/features/chat/widgets/message_text_or_image.dart';
import '../../../core/constants/const_color.dart';

class SenderMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum messageEnum;
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.messageEnum,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: senderMessageColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MessageTextOrImage(
                  data: message,
                  messageEnum: messageEnum,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
