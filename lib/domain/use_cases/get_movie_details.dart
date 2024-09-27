import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class GetMovieDetails extends UseCase<MovieDetailEntity, MovieParams> {
  final MovieRepos repos;

  GetMovieDetails(this.repos);
  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams params) async {
    return await repos.getMovieDetail(params.movieId);
  }
}
