import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:green_pal_tracker/shared/models/repository_error.dart';
import 'package:green_pal_tracker/shared/repository/base_repository.dart';

class CacheManager extends BaseRepository {
  Future<Either<RepositoryError, List<T>>> fetchAndCacheData<T>({
    required String cacheKey,
    required Future<Response> Function() fetchFromApi,
    required Function() getFromDb,
    required Future<void> Function(List<T> data) saveToDb,
    required List<T> Function(dynamic json) fromJson,
    Function()? getFreshDataFromDb,
  }) async {
    try {
      final cachedData = getFreshDataFromDb != null ? getFreshDataFromDb() : getFromDb();

      if (cachedData != null) {
        return Right(cachedData);
      }

      final response = await fetchFromApi();
      final data = fromJson(response.data);

      await saveToDb(data);

      return Right(data);
    } catch (error, stackTrace) {
      final cachedData = getFromDb();
      if (cachedData != null) {
        return Right(cachedData);
      }
      return Left(
        handleError(
          location: 'CacheManager.fetchAndCacheData',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
