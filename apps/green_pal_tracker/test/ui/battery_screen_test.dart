import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:green_pal_tracker/graph/data/repository/graph_repository.dart';
import 'package:green_pal_tracker/graph/data/utils/graph_utils.dart';
import 'package:green_pal_tracker/graph/ui/blocs/battery/battery_bloc.dart';
import 'package:green_pal_tracker/graph/ui/pages/battery/battery_screen.dart';
import 'package:green_pal_ui/widgets/error_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helpers/mocks.mocks.dart';
import '../test_helpers/test_data.dart';

class MockBatteryBloc extends Mock implements BatteryBloc {}

void main() {
  late MockBatteryBloc mockBloc;

  setUpAll(() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<GraphRepository>(() => MockGraphRepository());
  });

  setUp(() {
    mockBloc = MockBatteryBloc();
  });

  group('BatteryScreen Widget Tests', () {
    testWidgets('shows loading indicator when state is LoadingBatteryState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(const LoadingBatteryState());
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const LoadingBatteryState()));

      await tester.pumpWidget(
        BlocProvider<BatteryBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(home: Scaffold(body: BatteryScreen())),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error screen when state is ErrorBatteryState', (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';
      when(() => mockBloc.state).thenReturn(const ErrorBatteryState(message: errorMessage));
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(const ErrorBatteryState(message: errorMessage)));

      await tester.pumpWidget(
        BlocProvider<BatteryBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: BatteryScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CustomErrorScreen), findsOneWidget);
    });

    testWidgets('renders components correctly when state is SuccessBatteryState', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(SuccessBatteryState(
        testGraphData,
        EnergyUnit.watt,
        DateTime(2024, 11, 16),
      ));
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        BlocProvider<BatteryBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: BatteryScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Gap), findsOneWidget);
    });
  });
}
