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

class _VideoCardState extends State<VideoCard>
    with AutomaticKeepAliveClientMixin {
  late YoutubePlayerController controller;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    String videoId = YoutubePlayer.convertUrlToId(widget.news.videoUrl) ?? "";

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
        disableDragSeek: true,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {
      controller.play();
    } else {
      controller.pause();
      TTSService.stop();
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
        /// 🎥 YOUTUBE VIDEO
        SizedBox.expand(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
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

                Text(
                  widget.news.headline,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(widget.news.caption),

                const SizedBox(height: 12),

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
