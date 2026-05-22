import 'package:tecnar_tok/core/errors/failures.dart';
import 'package:tecnar_tok/core/usecases/usecase.dart';
import 'package:tecnar_tok/features/feed/domain/entities/video.dart';
import 'package:tecnar_tok/features/feed/domain/repositories/video_repository.dart';

class GetVideos implements UseCase<List<Video>, NoParams> {
  final VideoRepository repository;

  GetVideos(this.repository);

  @override
  Future<Either<Failure, List<Video>>> call(NoParams params) async {
    return await repository.getVideos();
  }
}