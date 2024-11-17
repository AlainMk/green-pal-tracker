import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/api/graph_api.dart';
import 'package:green_pal_tracker/graph/data/api/graph_local_api.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/shared/manager/cache_manager.dart';
import 'package:green_pal_tracker/shared/models/repository_error.dart';
import 'package:green_pal_tracker/shared/repository/base_repository.dart';
import 'package:intl/intl.dart';

class GraphRepository extends BaseRepository {
  final GraphApi _api = GetIt.instance.get<GraphApi>();
  final GraphLocalDB _db = GetIt.instance.get<GraphLocalDB>();
  final CacheManager _cacheManager = GetIt.instance.get<CacheManager>();

  Future<Either<RepositoryError, List<GraphData>>> getMonitoringData(
    GraphType type, {
    DateTime? date,
  }) async {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    final requestedDate = date ?? DateTime.now();
    final convertedDate = formatter.format(requestedDate);
    final cacheKey = '${type.name}_$convertedDate';

    return _cacheManager.fetchAndCacheData<GraphData>(
      cacheKey: cacheKey,
      fetchFromApi: () => _api.getMonitoringData(type.name, convertedDate),
      getFromDb: () => _db.getData(cacheKey),
      getFreshDataFromDb: () => DateUtils.isSameDay(requestedDate, DateTime.now()) ? _db.getDataIfFresh(cacheKey) : null,
      saveToDb: (data) => _db.saveData(cacheKey, data),
      fromJson: (json) => GraphData.fromJsonList(json),
    );
  }

  Future<void> clearCache() async {
    await _db.clearData();
  }
}
