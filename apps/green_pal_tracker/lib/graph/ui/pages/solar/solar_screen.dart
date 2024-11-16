import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/graph/ui/blocs/solar/solar_bloc.dart';
import 'package:green_pal_tracker/graph/ui/widgets/error_screen.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_tracker/graph/ui/widgets/line_chart.dart';
import 'package:green_pal_ui/theme/border_radius.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/theme/utils.dart';

class SolarScreen extends StatelessWidget {
  const SolarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolarBloc()..add(const GetSolarData()),
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
            return ListView(
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
                EnergyLineChart(items: solarState.dataList),
                const Gap(GreenPalSpacing.largeXxl),
                Container(
                  padding: const EdgeInsets.all(GreenPalSpacing.large),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(GreenPalBorderRadius.big),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Energy Generated",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Gap(GreenPalSpacing.normal),
                      Text(
                        solarState.totalEnergyGenerated,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
