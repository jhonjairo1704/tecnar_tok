import 'package:flutter/material.dart';
import 'package:tecnar_tok/features/feed/domain/entities/video.dart';
import 'package:tecnar_tok/features/feed/domain/usecases/get_videos.dart';
import 'package:tecnar_tok/core/usecases/usecase.dart';

class FeedProvider extends ChangeNotifier {
  final GetVideos getVideosUseCase;
  List<Video> _videos = [];
  bool _isLoading = false;
  String? _errorMessage;

  FeedProvider({required this.getVideosUseCase});

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadVideos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getVideosUseCase(NoParams());
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (videos) {
        _videos = videos;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void toggleLike(String videoId) {
    final index = _videos.indexWhere((v) => v.id == videoId);
    if (index != -1) {
      final video = _videos[index];
      final updatedVideo = video.copyWith(
        isLiked: !video.isLiked,
        likes: video.isLiked ? video.likes - 1 : video.likes + 1,
      );
      _videos[index] = updatedVideo;
      notifyListeners();
    }
  }
}