import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/news_model.dart';
import '../services/tts_service.dart';
import 'glass_card.dart';

class VideoCard extends StatefulWidget {
  final NewsModel news;
  final bool isActive;

  const VideoCard({super.key, required this.news, required this.isActive});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  // 🔥 Separate function for clean reuse
  void _initController() {
    final videoId = YoutubePlayer.convertUrlToId(widget.news.videoUrl);

    if (videoId == null || videoId.isEmpty) {
      print("❌ Invalid URL: ${widget.news.videoUrl}");
    }

    controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
        disableDragSeek: true,
      ),
    );
  }

  @override
  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.news.videoUrl != widget.news.videoUrl) {
      controller.pause();
      controller.dispose();

      final videoId = YoutubePlayer.convertUrlToId(widget.news.videoUrl) ?? "";

      controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );

      setState(() {}); // 🔥 FORCE UI UPDATE
    }

    if (widget.isActive) {
      controller.play();
    } else {
      controller.pause();
      controller.mute();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleListen() {
    final text =
        "${widget.news.headline}. ${widget.news.caption}. Source: ${widget.news.source}";
    TTSService.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 🎥 VIDEO WITH TAP CONTROL
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              controller.mute();
            } else {
              controller.unMute();
              controller.play();
            }
          },
          child: SizedBox.expand(
            child: YoutubePlayer(
              key: ValueKey(widget.news.videoUrl), // 🔥 IMPORTANT
              controller: controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ),

        /// 🧊 OVERLAY
        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// VERIFIED + SOURCE
                Row(
                  children: [
                    Icon(
                      widget.news.isVerified ? Icons.verified : Icons.warning,
                      color: widget.news.isVerified
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(widget.news.source),
                  ],
                ),

                const SizedBox(height: 10),

                /// HEADLINE
                Text(
                  widget.news.headline,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                /// CAPTION
                Text(widget.news.caption),

                const SizedBox(height: 12),

                /// ACTION
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: handleListen,
                      icon: const Icon(Icons.volume_up),
                      label: const Text("Listen"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
