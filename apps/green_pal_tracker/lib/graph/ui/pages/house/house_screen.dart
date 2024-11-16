import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/graph/ui/blocs/house/house_bloc.dart';
import 'package:green_pal_tracker/graph/ui/widgets/error_screen.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_tracker/graph/ui/widgets/line_chart.dart';
import 'package:green_pal_ui/theme/border_radius.dart';
import 'package:green_pal_ui/theme/spacing.dart';
import 'package:green_pal_ui/theme/utils.dart';

class HouseScreen extends StatelessWidget {
  const HouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HouseBloc()..add(const GetHouseData()),
      child: Builder(builder: (context) {
        return BlocConsumer<HouseBloc, HouseState>(
          listener: (context, state) {
            if (state is ErrorHouseState) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingHouseState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorHouseState) {
              return CustomErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<HouseBloc>().add(const GetHouseData());
                },
              );
            }

            final houseState = (state as SuccessHouseState);
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: GreenPalSpacing.large),
              children: [
                GraphHeader(
                  title: "House Consumption",
                  initialDate: houseState.date,
                  initialUnit: houseState.unit.index,
                  onDateSelected: (d) {
                    context.read<HouseBloc>().add(GetHouseData(date: d));
                  },
                  onToggle: (i) {
                    context.read<HouseBloc>().add(ChangeUnit(i));
                  },
                ),
                const Gap(GreenPalSpacing.largeXl),
                EnergyLineChart(
                  items: houseState.dataList,
                  lineColor: Theme.of(context).primaryColor,
                ),
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
                        houseState.totalEnergyGenerated,
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
