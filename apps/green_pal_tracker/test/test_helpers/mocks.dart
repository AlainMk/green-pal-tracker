import 'package:green_pal_tracker/graph/data/api/graph_api.dart';
import 'package:green_pal_tracker/graph/data/db/graph_local_db.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/shared/manager/cache_manager.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([GraphApi, GraphLocalDB, CacheManager, GraphRepository])
void main() {}
