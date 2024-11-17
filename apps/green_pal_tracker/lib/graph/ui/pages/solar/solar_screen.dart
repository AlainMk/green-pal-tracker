import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/graph/ui/blocs/solar/solar_bloc.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_tracker/graph/ui/widgets/line_chart.dart';
import 'package:green_pal_tracker/graph/ui/widgets/total_data_card.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/theme/utils.dart';
import 'package:green_pal_ui/widgets/error_screen.dart';

class SolarScreen extends StatelessWidget {
  const SolarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolarBloc()
        ..add(const GetSolarData())
        ..add(StartPolling()),
      child: Builder(builder: (context) {
        return BlocConsumer<SolarBloc, SolarState>(
          listener: (context, state) {
            if (state is ErrorSolarState) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingSolarState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorSolarState) {
              return CustomErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<SolarBloc>().add(const GetSolarData());
                },
              );
            }

            final solarState = (state as SuccessSolarState);
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SolarBloc>().add(GetSolarData(date: solarState.date));
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: GreenPalSpacing.large),
                children: [
                  GraphHeader(
                    title: "Solar Generation",
                    initialDate: solarState.date,
                    initialUnit: solarState.unit.index,
                    onDateSelected: (d) {
                      context.read<SolarBloc>().add(GetSolarData(date: d));
                    },
                    onToggle: (i) {
                      context.read<SolarBloc>().add(ChangeUnit(i));
                    },
                  ),
                  const Gap(GreenPalSpacing.largeXl),
                  EnergyLineChart(
                    items: solarState.dataList,
                    lineColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const Gap(GreenPalSpacing.largeXxl),
                  TotalDataCard(value: solarState.totalEnergyGenerated)
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
