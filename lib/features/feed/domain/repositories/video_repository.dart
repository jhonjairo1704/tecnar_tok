import 'package:tecnar_tok/core/errors/failures.dart';
import 'package:tecnar_tok/core/usecases/usecase.dart';
import 'package:tecnar_tok/features/feed/domain/entities/video.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<Video>>> getVideos();
}