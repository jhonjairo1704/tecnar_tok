import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tecnar_tok/features/feed/domain/entities/video.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;
  final bool isPaused;
  final VoidCallback onLike;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.isPaused,
    required this.onLike,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (widget.video.url.startsWith('assets/')) {
      _controller = VideoPlayerController.asset(widget.video.url);
    } else {
      _controller = VideoPlayerController.network(widget.video.url);
    }
    await _controller.initialize();
    _controller.setLooping(true);
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_controller.value.isInitialized)
          GestureDetector(
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
              setState(() {});
            },
            child: VideoPlayer(_controller),
          )
        else
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        Positioned(
          right: 10,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton(
                icon: Icons.favorite,
                iconColor: widget.video.isLiked ? Colors.red : Colors.white,
                label: '${widget.video.likes}',
                onTap: widget.onLike,
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.comment,
                label: '45',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.share,
                label: 'Compartir',
                onTap: () {},
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          bottom: 40,
          right: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.video.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.video.caption,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    Color? iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: iconColor ?? Colors.white, size: 35),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}