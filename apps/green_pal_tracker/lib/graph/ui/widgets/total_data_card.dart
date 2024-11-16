import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_ui/theme/border_radius.dart';
import 'package:green_pal_ui/theme/spacing.dart';

class TotalDataCard extends StatelessWidget {
  const TotalDataCard({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GreenPalSpacing.large),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
