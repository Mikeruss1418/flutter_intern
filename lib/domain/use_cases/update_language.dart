import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repos/app_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepos repos;

  UpdateLanguage(this.repos);
  @override
  Future<Either<AppError, void>> call(String params) async {
    return await repos.updatelanguage(params);
  }
}
