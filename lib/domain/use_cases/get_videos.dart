import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams> {
  final MovieRepos repos;

  GetVideos(this.repos);

  @override
  Future<Either<AppError, List<VideoEntity>>> call(MovieParams params) async {
    return await repos.getVideos(params.movieId);
  }
}
