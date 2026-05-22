import 'package:tecnar_tok/core/errors/failures.dart';
import 'package:tecnar_tok/core/usecases/usecase.dart';
import 'package:tecnar_tok/features/feed/data/datasources/video_local_data_source.dart';
import 'package:tecnar_tok/features/feed/domain/entities/video.dart';
import 'package:tecnar_tok/features/feed/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoLocalDataSource localDataSource;

  VideoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Video>>> getVideos() async {
    try {
      final localVideos = await localDataSource.getLocalVideos();
      return Either.right(localVideos);
    } catch (e) {
      return Either.left(CacheFailure('Error al cargar los videos'));
    }
  }
}