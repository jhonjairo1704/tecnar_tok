import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnar_tok/features/feed/presentation/providers/feed_provider.dart';
import 'package:tecnar_tok/features/feed/presentation/widgets/video_player_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedProvider>().loadVideos();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FeedProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadVideos(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (provider.videos.isEmpty) {
            return const Center(
              child: Text(
                'No hay videos disponibles.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: provider.videos.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final video = provider.videos[index];
              return VideoPlayerWidget(
                video: video,
                isPaused: index != _currentIndex,
                onLike: () => provider.toggleLike(video.id),
              );
            },
          );
        },
      ),
    );
  }
}