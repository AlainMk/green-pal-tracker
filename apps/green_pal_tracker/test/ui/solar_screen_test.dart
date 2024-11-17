import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/solar/solar_bloc.dart';
import 'package:green_pal_tracker/graph/ui/pages/solar/solar_screen.dart';
import 'package:green_pal_ui/widgets/error_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helpers/mocks.mocks.dart';
import '../test_helpers/test_data.dart';

class MockSolarBloc extends Mock implements SolarBloc {}

void main() {
  late MockSolarBloc mockBloc;

  setUpAll(() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<GraphRepository>(() => MockGraphRepository());
  });

  setUp(() {
    mockBloc = MockSolarBloc();
  });

  group('SolarScreen Widget Tests', () {
    testWidgets('shows loading indicator when state is LoadingSolarState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(const LoadingSolarState());
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const LoadingSolarState()));

      await tester.pumpWidget(
        BlocProvider<SolarBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(home: Scaffold(body: SolarScreen())),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error screen when state is ErrorSolarState', (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';
      when(() => mockBloc.state).thenReturn(const ErrorSolarState(message: errorMessage));
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const ErrorSolarState(message: errorMessage)));

      await tester.pumpWidget(
        BlocProvider<SolarBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: SolarScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CustomErrorScreen), findsOneWidget);
    });

    testWidgets('renders components correctly when state is SuccessSolarState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SuccessSolarState(
        testGraphData,
        EnergyUnit.watt,
        DateTime(2024, 11, 16),
      ));
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        BlocProvider<SolarBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: SolarScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Gap), findsOneWidget);
    });
  });
}
