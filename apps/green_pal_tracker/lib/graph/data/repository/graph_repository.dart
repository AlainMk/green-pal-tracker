import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/api/graph_api.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/shared/models/repository_error.dart';
import 'package:green_pal_tracker/shared/repository/base_repository.dart';
import 'package:intl/intl.dart';

class GraphRepository extends BaseRepository {
  final GraphApi _api = GetIt.instance.get<GraphApi>();

  Future<Either<RepositoryError, List<GraphData>>> getMonitoringData(GraphType type, {DateTime? date}) async {
    try {
      final DateFormat formatter = DateFormat("yyyy-MM-dd");
      final convertedDate = formatter.format(date ?? DateTime.now());

      final response = await _api.getMonitoringData(type.name, convertedDate);
      final data = GraphData.fromJsonList(response.data);
      return Right(data);
    } catch (error, stackTrace) {
      return Left(
        handleError(
          location: '$runtimeType.getMonitoringData()',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
