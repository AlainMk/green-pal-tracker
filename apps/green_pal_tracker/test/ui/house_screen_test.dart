import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/house/house_bloc.dart';
import 'package:green_pal_tracker/graph/ui/pages/house/house_screen.dart';
import 'package:green_pal_ui/widgets/error_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helpers/mocks.mocks.dart';
import '../test_helpers/test_data.dart';

class MockHouseBloc extends Mock implements HouseBloc {}

void main() {
  late MockHouseBloc mockBloc;

  setUpAll(() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<GraphRepository>(() => MockGraphRepository());
  });

  setUp(() {
    mockBloc = MockHouseBloc();
  });

  group('HouseScreen Widget Tests', () {
    testWidgets('shows loading indicator when state is LoadingHouseState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(const LoadingHouseState());
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const LoadingHouseState()));

      await tester.pumpWidget(
        BlocProvider<HouseBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(home: Scaffold(body: HouseScreen())),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error screen when state is ErrorHouseState', (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';
      when(() => mockBloc.state).thenReturn(const ErrorHouseState(message: errorMessage));
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const ErrorHouseState(message: errorMessage)));

      await tester.pumpWidget(
        BlocProvider<HouseBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: HouseScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CustomErrorScreen), findsOneWidget);
    });

    testWidgets('renders components correctly when state is SuccessHouseState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SuccessHouseState(
        testGraphData,
        EnergyUnit.watt,
        DateTime(2024, 11, 16),
      ));
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        BlocProvider<HouseBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: HouseScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Gap), findsOneWidget);
    });
  });
}
