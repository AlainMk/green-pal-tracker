import 'package:flutter/material.dart';
import 'package:green_pal_tracker/graph/ui/widgets/header.dart';
import 'package:green_pal_ui/theme/spacing.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: GreenPalSpacing.large),
      children: [
        GraphHeader(
          title: "Battery Consumption",
          initialDate: DateTime.now(),
          initialUnit: 0,
          onDateSelected: (d) {},
          onToggle: (i) {},
        ),
      ],
    );
  }
}
