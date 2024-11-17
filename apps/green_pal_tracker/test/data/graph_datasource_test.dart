import 'package:flutter_test/flutter_test.dart';
import 'package:green_pal_tracker/graph/data/models/graph_data.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/shared/manager/cache_manager.dart';
import 'package:green_pal_tracker/shared/models/repository_error.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers/mocks.mocks.dart';
import '../test_helpers/test_data.dart';

void main() {
  late MockGraphApi mockApi;
  late MockGraphLocalDB mockDb;
  late CacheManager cacheManager;

  setUp(() {
    mockApi = MockGraphApi();
    mockDb = MockGraphLocalDB();
    cacheManager = CacheManager();
  });

  group('CacheManager.fetchAndCacheData', () {
    const cacheKey = 'solar_2024-11-16';

    test('returns fresh cached data if available', () async {
      when(mockDb.getDataIfFresh(cacheKey)).thenReturn(testGraphData);

      final result = await cacheManager.fetchAndCacheData(
        cacheKey: cacheKey,
        fetchFromApi: () async => throw Exception('Should not call API'),
        getFromDb: () => null,
        saveToDb: (_) async {},
        fromJson: (json) => [],
        getFreshDataFromDb: () => mockDb.getDataIfFresh(cacheKey),
      );

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => []), equals(testGraphData));
      verify(mockDb.getDataIfFresh(cacheKey)).called(1);
      verifyNever(mockDb.saveData(any, any));
    });

    test('fetches from API and caches if no fresh data is available', () async {
      when(mockDb.getDataIfFresh(cacheKey)).thenReturn(null);
      when(mockDb.getData(cacheKey)).thenReturn(null);
      when(mockApi.getMonitoringData(any, any)).thenAnswer((_) async => mockApiResponse);
      when(mockDb.saveData(any, any)).thenAnswer((_) async {});

      final result = await cacheManager.fetchAndCacheData(
        cacheKey: cacheKey,
        fetchFromApi: () async => mockApi.getMonitoringData('solar', '2024-11-16'),
        getFromDb: () => mockDb.getData(cacheKey),
        saveToDb: (data) async => mockDb.saveData(cacheKey, data),
        fromJson: (json) => GraphData.fromJsonList(json),
      );

      expect(result.isRight(), isTrue);
      verify(mockApi.getMonitoringData(any, any)).called(1);
      verify(mockDb.saveData(cacheKey, any)).called(1);
    });

    test('falls back to stale cache if API fails', () async {
      const testType = GraphType.solar;
      final testDate = DateTime(2024, 11, 16);
      final cacheKey = '${testType.name}_$testDate';
      when(mockDb.getDataIfFresh(cacheKey)).thenReturn(null);
      when(mockDb.getData(cacheKey)).thenReturn(testGraphData);
      when(mockApi.getMonitoringData(testType.name, cacheKey)).thenThrow(Exception('API error'));

      final result = await cacheManager.fetchAndCacheData(
        cacheKey: cacheKey,
        fetchFromApi: () async => throw Exception('API error'),
        getFromDb: () => mockDb.getData(cacheKey),
        saveToDb: (_) async {},
        fromJson: (json) => [],
      );

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => []), equals(testGraphData));
      verify(mockDb.getData(cacheKey)).called(1);
    });

    test('returns error if no cache and API fails', () async {
      const testType = GraphType.solar;
      final testDate = DateTime(2024, 11, 16);
      final cacheKey = '${testType.name}_$testDate';
      when(mockDb.getDataIfFresh(cacheKey)).thenReturn(null);
      when(mockDb.getData(cacheKey)).thenReturn(null);
      when(mockApi.getMonitoringData(testType.name, cacheKey)).thenThrow(Exception('API error'));

      final result = await cacheManager.fetchAndCacheData(
        cacheKey: cacheKey,
        fetchFromApi: () async => throw Exception('API error'),
        getFromDb: () => mockDb.getData(cacheKey),
        saveToDb: (_) async {},
        fromJson: (json) => [],
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (error) => expect(error, isA<RepositoryError>()),
        (_) => fail('Expected an error but got data'),
      );
    });
  });
}
