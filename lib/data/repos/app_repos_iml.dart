import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data_sources/language_local_data_source.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repos/app_repos.dart';

class AppReposIml extends AppRepos {
  final LanguageLocalDataSource languageLocalDataSource;

  AppReposIml(this.languageLocalDataSource);
  @override
  Future<Either<AppError, String>> getPreferredlang() async {
    try {
      final response = await languageLocalDataSource.getPreferredlang();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updatelanguage(String language) async {
    try {
      final response = await languageLocalDataSource.updatelanguage(language);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database),);
    }
  }
}
