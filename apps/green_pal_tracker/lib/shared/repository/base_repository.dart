import 'package:dio/dio.dart';
import 'package:green_pal_tracker/shared/models/repository_error.dart';
import 'package:logger/logger.dart';

abstract class BaseRepository {
  final Logger _logger = Logger(
    printer: PrettyPrinter(colors: false),
  );

  RepositoryError handleError({
    required String location,
    required dynamic error,
    required StackTrace? stackTrace,
  }) {
    if (error is! DioException) {
      _logger.e(location, error: error, stackTrace: stackTrace);
    }
    if (error is DioException) {
      _logger.e(location, error: error, stackTrace: stackTrace);
      return RepositoryError(error: "Something went wrong! Please try again", stackTrace: stackTrace);
    }

    return RepositoryError(error: error.toString(), stackTrace: stackTrace);
  }
}
