import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class SaveMovie extends UseCase<void, MovieEntity> {
  final MovieRepos repos;

  SaveMovie(this.repos);

  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    return await repos.saveMovie(params);
  }
}
