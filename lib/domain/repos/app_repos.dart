import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

abstract class AppRepos {
  Future<Either<AppError, void>> updatelanguage(String language);
  Future<Either<AppError, String>> getPreferredlang();
}
