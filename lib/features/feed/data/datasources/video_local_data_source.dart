import 'package:tecnar_tok/features/feed/domain/entities/video.dart';

abstract class VideoLocalDataSource {
  Future<List<Video>> getLocalVideos();
}

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  @override
  Future<List<Video>> getLocalVideos() async {
    return [
      Video(
        id: '1',
        url: 'assets/videos/bee.mp4',
        username: '@tecnar_user',
        caption: 'Abeja en cámara lenta',
        likes: 120,
      ),
      Video(
        id: '2',
        url: 'assets/videos/butterfly.mp4',
        username: '@flutter_dev',
        caption: 'Mariposa polinizando',
        likes: 1540,
      ),
    ];
  }
}