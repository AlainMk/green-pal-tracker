import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/graph/ui/blocs/battery/battery_bloc.dart';
import 'package:green_pal_tracker/graph/ui/widgets/error_screen.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_tracker/graph/ui/widgets/line_chart.dart';
import 'package:green_pal_tracker/graph/ui/widgets/total_data_card.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/theme/utils.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BatteryBloc()
        ..add(const GetBatteryData())
        ..add(StartPolling()),
      child: Builder(builder: (context) {
        return BlocConsumer<BatteryBloc, BatteryState>(
          listener: (context, state) {
            if (state is ErrorBatteryState) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingBatteryState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorBatteryState) {
              return CustomErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<BatteryBloc>().add(const GetBatteryData());
                },
              );
            }

            final batteryState = (state as SuccessBatteryState);
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BatteryBloc>().add(GetBatteryData(date: batteryState.date));
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: GreenPalSpacing.large),
                children: [
                  GraphHeader(
                    title: "Battery Consumption",
                    initialDate: batteryState.date,
                    initialUnit: batteryState.unit.index,
                    onDateSelected: (d) {
                      context.read<BatteryBloc>().add(GetBatteryData(date: d));
                    },
                    onToggle: (i) {
                      context.read<BatteryBloc>().add(ChangeUnit(i));
                    },
                  ),
                  const Gap(GreenPalSpacing.largeXl),
                  EnergyLineChart(
                    items: batteryState.dataList,
                    lineColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  const Gap(GreenPalSpacing.largeXxl),
                  TotalDataCard(value: batteryState.totalEnergyGenerated)
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
