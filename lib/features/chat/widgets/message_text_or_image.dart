import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_app/core/enums/message_enum.dart';

class MessageTextOrImage extends StatefulWidget {
  final String data;
  final MessageEnum messageEnum;
  const MessageTextOrImage({
    super.key,
    required this.data,
    required this.messageEnum,
  });

  @override
  State<MessageTextOrImage> createState() => _MessageTextOrImageState();
}

class _MessageTextOrImageState extends State<MessageTextOrImage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    if (widget.messageEnum == MessageEnum.video) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.data))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    if (widget.messageEnum == MessageEnum.video) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (() {
      switch (widget.messageEnum) {
        case MessageEnum.image:
          return CachedNetworkImage(
            imageUrl: widget.data,
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
        case MessageEnum.video:
          return Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.value.isPlaying
                      ? Colors.transparent
                      : Colors.black,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        default:
          return Text(
            widget.data,
            style: const TextStyle(
              fontSize: 16,
            ),
          );
      }
    }());
  }
}
