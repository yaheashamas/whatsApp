import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/core/enums/message_enum.dart';

class MessageTextOrImage extends StatelessWidget {
  final String data;
  final MessageEnum messageEnum;
  const MessageTextOrImage({
    super.key,
    required this.data,
    required this.messageEnum,
  });

  @override
  Widget build(BuildContext context) {
    return (() {
      switch (messageEnum) {
        case MessageEnum.image:
          return CachedNetworkImage(
            imageUrl: data,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            maxHeightDiskCache: 200,
            maxWidthDiskCache: 300,
            height: 200,
            width: 300,
          );
        default:
          return Text(
            data,
            style: const TextStyle(
              fontSize: 16,
            ),
          );
      }
    }());
  }
}
